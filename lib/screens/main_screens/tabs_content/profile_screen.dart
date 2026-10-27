import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onstagram/helpers/consts.dart';
import 'package:onstagram/helpers/functions.dart';
import 'package:onstagram/providers/auth_provider.dart';
import 'package:onstagram/providers/dark_mode_provider.dart';
import 'package:onstagram/screens/main_screens/sub_screens/edit_profile_screen.dart';
import 'package:onstagram/widgets/clickables/app_button.dart';
import 'package:onstagram/widgets/statics/tilted_value.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).getMe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<DarkModeProvider, AuthProvider>(
      builder: (context, darkModeConsumer, authConsumer, _) {
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Icon(CupertinoIcons.lock),
                  SizedBox(width: 12),
                  Text(
                    authConsumer.currentUser == null || authConsumer.busyMore
                        ? "loading..."
                        : authConsumer.currentUser!.username,
                    style: labelMedium,
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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

                        SizedBox(width: 24),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                authConsumer.currentUser == null
                                    ? "loading..."
                                    : authConsumer.currentUser!.name,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TitledValue(
                                    title: "posts",
                                    value: authConsumer.currentUser == null
                                        ? "..."
                                        : authConsumer
                                              .currentUser!
                                              .stats
                                              .postsCount
                                              .toString(),
                                  ),
                                  TitledValue(
                                    title: "followers",
                                    value: authConsumer.currentUser == null
                                        ? "..."
                                        : authConsumer
                                              .currentUser!
                                              .stats
                                              .followersCount
                                              .toString(),
                                  ),
                                  TitledValue(
                                    title: "following",
                                    value: authConsumer.currentUser == null
                                        ? "..."
                                        : authConsumer
                                              .currentUser!
                                              .stats
                                              .followingsCount
                                              .toString(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12),

                    Text(
                      authConsumer.currentUser == null
                          ? "laoding bio in progress..."
                          : authConsumer.currentUser!.bio,
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: AppButton(
                        interialPadding: 0,
                        hPadding: 0,
                        vPadding: 0,
                        onPressed: () {
                          authConsumer.logout();
                        },
                        label: "D",
                        btnColor: Colors.black12,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      flex: 7,
                      child: AppButton(
                        interialPadding: 4,

                        hPadding: 0,
                        vPadding: 0,
                        onPressed: () {
                          if (authConsumer.currentUser != null &&
                              !authConsumer.busy &&
                              !authConsumer.busyMore) {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => EditProfileScreen(
                                  upm: authConsumer.currentUser!,
                                ),
                              ),
                            );
                          }
                        },
                        label: "Edit Profile",
                        btnColor: Colors.black12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
