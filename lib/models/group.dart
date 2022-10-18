class Group {
  final String groupId;
  final String name;
  final List members;
  final String groupAdminId;

  Group({
    required this.groupId,
    required this.name,
    required this.members,
    required this.groupAdminId,
  });

  Map<String, dynamic> toJson() => {
        'groupId': groupId,
        'name': name,
        'members': members,
        'groupAdminId': groupAdminId,
      };
}
