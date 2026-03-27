import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/shared/posts_grid/views/posts_grid_view.dart';
import 'package:instagram_clone/shared/search_field.dart';

import '../controllers/explorer_controller.dart';

class ExplorerView extends GetView<ExplorerController> {
  const ExplorerView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: Navigator.canPop(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SearchTextField(
            onTap: controller.onSearchFieldPressed,
            isReadOnly: true,
            textController: controller.searchTextController,
          ),

          Expanded(
            child: PostsGridView(
              controller: controller.postsGridController,
            ),
          ),
        ],
      ),
    );
  }

}
