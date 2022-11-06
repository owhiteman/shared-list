class Group {
  final String groupId;
  final String name;
  final List members;
  final String groupAdminId;
  final List<String> notes;

  Group({
    required this.groupId,
    required this.name,
    required this.members,
    required this.groupAdminId,
    required this.notes,
  });

  Map<String, dynamic> toJson() => {
        'groupId': groupId,
        'name': name,
        'members': members,
        'groupAdminId': groupAdminId,
        'notes': notes
      };
}
