import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("AddPostScreen"));
  }
}
