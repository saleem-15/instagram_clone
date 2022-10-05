import 'package:flutter/material.dart';

import 'package:get/get.dart';

class FollowersView extends GetView {
  const FollowersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FollowersView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FollowersView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
