import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AddPostView extends GetView {
  const AddPostView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
