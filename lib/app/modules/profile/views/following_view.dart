import 'package:flutter/material.dart';

import 'package:get/get.dart';

class FollowingView extends GetView {
  const FollowingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FollowingView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'FollowingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
