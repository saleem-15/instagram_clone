// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:instagram_clone/app/routes/app_pages.dart';

import '../../../../config/theme/my_fonts.dart';
import '../../../models/user.dart';

class StoriesView extends StatelessWidget {
  const StoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: users.length,
            itemBuilder: (context, index) {
              return StoryTile(user: users[index]);
            },
          ),
        )
      ],
    );
  }
}

class StoryTile extends StatelessWidget {
  StoryTile({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  bool isWatched = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.STORY);
      },
      child: Padding(
        padding: const EdgeInsets.only(
          right: 10,
          left: 10,
          top: 10,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                gradient: isWatched
                    ? null
                    : const LinearGradient(
                        begin: Alignment.topCenter,
                        colors: [
                          Color(0xff515BD4),
                          Color(0xff8134AF),
                          Color(0xffDD2A7B),
                          Color(0xffFEDA77),
                          Color(0xffF58529),
                        ],
                      ),
                shape: BoxShape.circle,
                border: isWatched
                    ? Border.all(
                        color: Colors.grey.shade300,
                        width: 2,
                        style: BorderStyle.solid,
                      )
                    : null,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(user.image ?? 'assets/images/greg.jpg'),
                ).marginAll(3),
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Text(
              user.name,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: MyFonts.bodySmallTextSize),
            ),
          ],
        ),
      ),
    );
  }
}

List<User> users = [
  User(
    id: '0',
    name: 'Ahmed',
    image: 'assets/images/james.jpg',
  ),
  User(
    id: '1',
    name: 'james',
    image: 'assets/images/james.jpg',
  ),
  User(
    id: '2',
    name: 'john',
    image: 'assets/images/john.jpg',
  ),
  User(
    id: '3',
    name: 'greg',
    image: 'assets/images/greg.jpg',
  ),
  User(
    id: '4',
    name: 'Olivia',
    image: 'assets/images/olivia.jpg',
  ),
  User(
    id: '5',
    name: 'Sam',
    image: 'assets/images/sam.jpg',
  ),
  User(
    id: '6',
    name: 'Sophia',
    image: 'assets/images/sophia.jpg',
  ),
  User(
    id: '7',
    name: 'Steven',
    image: 'assets/images/steven.jpg',
  ),
];
