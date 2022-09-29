class User {
  final String uid;
  final String name;
  final String email;
  String? displayPicUrl;
  String? groupId;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.displayPicUrl,
    this.groupId,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'displayPicUrl': displayPicUrl,
        'groupId': groupId,
      };
}
