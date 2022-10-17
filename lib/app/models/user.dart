// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String id;
  String name;
  String? image;
  bool isHasNewStory;
  User({
    required this.id,
    required this.name,
    required this.image,
    this.isHasNewStory = true,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'].toString(),
      name: map['name'],
      image: map['image'],
    );
  }
}
