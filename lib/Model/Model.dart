class UserFindUs {
  String? email, name, pasword, allow, phone;
  UserFindUs({this.allow, this.email, this.name, this.pasword, this.phone});
  factory UserFindUs.fromJson(Map<String, dynamic> json) {
    return UserFindUs(
        name: json['name'],
        email: json['email'],
        pasword: json['password'],
        allow: json['allow'],
        phone: json['phone']);
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "pasword": pasword,
      "allow": allow,
      "phone": phone
    };
  }
}

class Item {
  String? name,
      ob,
      gender,
      description,
      location,
      age,

      finditemlocation,
      UserFindUsId;
      bool? find;
      List<dynamic>? image;

  Item(
      {this.name,
      this.ob,
      this.image,
      this.gender,
      this.description,
      this.location,
      this.age,
        this.finditemlocation,
      this.UserFindUsId,
      this.find});
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      ob: json['ob'],
      image: json['image'] as List<dynamic>,
      gender: json['gender'],
      description: json['description'],
      location: json['location'],
      age: json['age'],
      finditemlocation: json['finditemlocation'],
      UserFindUsId: json['UserFindUsId'],
      find: json['find'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "ob": ob,
      "image": image,
      "gender": gender,
      "description": description,
      "location": location,
      "age": age,
      "finditemlocation" : finditemlocation,
      "UserFindUsId": UserFindUsId,
      "find": find
    };
  }
}
