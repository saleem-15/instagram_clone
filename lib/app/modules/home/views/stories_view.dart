import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/app/routes/app_pages.dart';

class StoriesView extends StatelessWidget {
  const StoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = Message.favorites;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.STORY);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(favorites[index].imageUrl),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          favorites[index].name,
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class Message {
  final TempUser sender;
  final String time;
  final String text;
  bool isLiked;
  final bool unread;

  Message({
    required this.isLiked,
    required this.sender,
    required this.text,
    required this.time,
    required this.unread,
  });

//me
  static TempUser currentUser = TempUser(
    id: 0,
    name: 'Current User',
    imageUrl: 'assets/images/james.jpg',
  );

  //USERS
  static TempUser james = TempUser(
    id: 1,
    name: 'james',
    imageUrl: 'assets/images/james.jpg',
  );

  static TempUser john = TempUser(
    id: 2,
    name: 'john',
    imageUrl: 'assets/images/john.jpg',
  );

  static TempUser greg = TempUser(
    id: 3,
    name: 'greg',
    imageUrl: 'assets/images/greg.jpg',
  );

  static TempUser olivia = TempUser(
    id: 4,
    name: 'Olivia',
    imageUrl: 'assets/images/olivia.jpg',
  );

  static TempUser sam = TempUser(
    id: 5,
    name: 'Sam',
    imageUrl: 'assets/images/sam.jpg',
  );

  static TempUser sophia = TempUser(
    id: 6,
    name: 'Sophia',
    imageUrl: 'assets/images/sophia.jpg',
  );

  static TempUser steven = TempUser(
    id: 7,
    name: 'Steven',
    imageUrl: 'assets/images/steven.jpg',
  );

  static List<TempUser> favorites = [sam, steven, olivia, john, greg];

  static List<Message> chats = [
    Message(
      sender: james,
      time: '5:30 PM ',
      text: 'Hey , how\'s it going ? What did you do today ?',
      isLiked: false,
      unread: true,
    ),
    Message(
      sender: olivia,
      time: '4:30 PM ',
      text: 'Hey , how\'s it going ? What did you do today ?',
      isLiked: false,
      unread: true,
    ),
    Message(
      sender: john,
      time: '3:30 PM',
      text: ' Hey , how \'s it going ? What did you do today ? ',
      isLiked: false,
      unread: false,
    ),
    Message(
      sender: sophia,
      time: '2:30 PM',
      text: ' Hey , how\'s it going ? What did you do today ? ',
      isLiked: false,
      unread: true,
    ),
    Message(
      sender: steven,
      time: '1:30 PM',
      text: ' Hey , how\'s it going ? What did you do today ? ',
      isLiked: false,
      unread: false,
    ),
    Message(
      sender: sam,
      time: '12:30 PM',
      text: ' Hey , how\'s it going ? What did you do today ? ',
      isLiked: false,
      unread: false,
    ),
    Message(
      sender: greg,
      time: '11:30 PM',
      text: ' Hey , how\'s it going ? What did you do today ? ',
      isLiked: false,
      unread: false,
    ),
  ];
}

class TempUser {
  final int id;
  final String name;
  final String imageUrl;

  TempUser({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
}
