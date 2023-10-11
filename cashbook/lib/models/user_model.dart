class UserModel {
  int? id;
  String? name;
  String? username;
  String? password;
  String? photo;

  UserModel({
    this.id,
    this.name,
    this.username,
    this.password,
    this.photo,
  });

  UserMap() {
    var mapping = <String, dynamic>{};
    mapping['id'] = id;
    mapping['name'] = name!;
    mapping['username'] = username!;
    mapping['password'] = password!;
    mapping['photo'] = photo!;
    return mapping;
  }
}
