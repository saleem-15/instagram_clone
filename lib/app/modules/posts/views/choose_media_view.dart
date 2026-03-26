import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AddPostView extends GetView {
  const AddPostView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: false,
      appBar: AppBar(
        primary: false,
        title: const Text('ChooseMediaView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ChooseMediaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
