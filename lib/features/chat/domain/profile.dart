class Profile {
  Profile(
    this.id,
    this.username,
    this.createdAt,
  );

  Profile.fromMap(Map<String, dynamic> map)
      : id = map['id'] as String,
        username = map['username'] as String,
        createdAt = DateTime.parse(map['created_at'] as String);

  final String id;
  final String username;
  final DateTime createdAt;
}
