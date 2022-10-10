import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExplorerController extends GetxController {
  final count = 0.obs;

  final TextEditingController searchTextController = TextEditingController();

  void increment() => count.value++;

  void search() {}
}
