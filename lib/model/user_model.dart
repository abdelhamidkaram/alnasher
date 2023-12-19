class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? gender;
  String? dob;
  String? about;
  String? image;

  UserModel(
      {this.id,
        this.firstName,
        this.lastName,
        this.phone,
        this.email,
        this.gender,
        this.dob,
        this.about,
        this.image});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    email = json['email'];
    gender = json['gender'];
    dob = json['dob'];
    about = json['about'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['phone'] = phone;
    data['email'] = email;
    data['gender'] = gender;
    data['dob'] = dob;
    data['about'] = about;
    data['image'] = image;
    return data;
  }
}
