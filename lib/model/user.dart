class UserModel{
  int id;
  String name;
  String email;
  int privileges;
  String createdAt;
  String updatedAt;

  UserModel({this.id, this.name, this.email, this.privileges, this.createdAt, this.updatedAt});

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      privileges: json['privileges'],
      createdAt: json['created_at'].toString(),
      updatedAt: json['updated_at'].toString()
    );
  }
}