import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onstagram/helpers/consts.dart';
import 'package:onstagram/helpers/functions.dart';
import 'package:onstagram/models/user_profile_model.dart';
import 'package:onstagram/providers/auth_provider.dart';
import 'package:onstagram/widgets/clickables/app_button.dart';
import 'package:onstagram/widgets/inputs/app_input.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const new({super.key, required this.upm});
  final UserProfileModel upm;
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  bool edited = false;

  @override
  void initState() {
    nameController.text = widget.upm.name;
    usernameController.text = widget.upm.username;
    bioController.text = widget.upm.bio;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authConsumer, _) {
        return Scaffold(
          appBar: AppBar(title: Text("Edit Profile")),
          body: Form(
            key: formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    final picker = ImagePicker();
                    // Pick an image.
                    await picker.pickImage(source: ImageSource.gallery).then((
                      file,
                    ) {
                      if (file != null) {
                        authConsumer.updateUserImage(File(file.path));
                      }
                    });
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(100),
                        child:
                            authConsumer.currentUser == null ||
                                authConsumer.busyMore
                            ? SizedBox(
                                width: getSize(context).width * 0.25,
                                height: getSize(context).width * 0.25,
                              )
                            : CachedNetworkImage(
                                imageUrl: authConsumer.currentUser!.photo,
                                width: getSize(context).width * 0.25,
                                height: getSize(context).width * 0.25,
                                fit: BoxFit.cover,

                                placeholder: (context, v) {
                                  return SizedBox(
                                    width: getSize(context).width * 0.25,
                                    height: getSize(context).width * 0.25,
                                  );
                                },
                                errorWidget: (context, v, _) {
                                  return SizedBox(
                                    width: getSize(context).width * 0.25,
                                    height: getSize(context).width * 0.25,
                                  );
                                },
                              ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Change photo",
                          style: labelSmall.copyWith(color: blueColor),
                        ),
                      ),
                    ],
                  ),
                ),

                AppInput(
                  customHint: "Name",
                  controller: nameController,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Name is required";
                    }

                    if (v.length < 2) {
                      return "Name must be more than 2 chars";
                    }
                    return null;
                  },
                  onChanged: () {
                    setState(() {
                      edited = true;
                    });
                  },
                ),

                AppInput(
                  enabled: false,
                  customHint: "Username",
                  controller: usernameController,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Name is required";
                    }

                    if (v.length < 2) {
                      return "Name must be more than 2 chars";
                    }
                    return null;
                  },
                  onChanged: () {},
                ),

                AppInput(
                  customHint: "Bio",
                  controller: bioController,
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Bio is required";
                    }

                    if (v.length < 2) {
                      return "Bio must be more than 2 chars";
                    }
                    return null;
                  },
                  onChanged: () {
                    setState(() {
                      edited = true;
                    });
                  },
                ),
                Spacer(),
                AppButton(
                  enabled: edited,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      authConsumer
                          .updateUser({
                            "name": nameController.text,
                            "bio": bioController.text,
                          }, widget.upm.id.toString())
                          .then((updateResult) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: updateResult.first
                                      ? greenColor
                                      : redColor,
                                  content: Text(updateResult.last),
                                ),
                              );
                              if (updateResult.first) {
                                Timer(Duration(seconds: 3), () {
                                  Navigator.pop(context);
                                });
                              }
                            }
                          });
                    }
                  },
                  label: "Save",
                  btnColor: blueColor,
                  isLoading: authConsumer.busyMore,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
