import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:instagram_clone/app/shared/search_field.dart';

import '../controllers/explorer_controller.dart';

class ExplorerView extends GetView<ExplorerController> {
  const ExplorerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SearchTextField(
              textController: controller.searchTextController,
              onEditingComplete: controller.search,
            )
          ],
        ),
      ),
    );
  }
}
