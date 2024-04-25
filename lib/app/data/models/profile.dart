class Profile {
  int? id;
  String? email;
  String? firstname;
  String? lastname;
  String? password;
  String? photo;
  String? createdAt;
  String? updatedAt;

  Profile(
      {this.id,
      this.email,
      this.firstname,
      this.lastname,
      this.password,
      this.photo,
      this.createdAt,
      this.updatedAt});

  Profile.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    password = json['password'];
    photo = json['photo'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['password'] = this.password;
    data['photo'] = this.photo;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
