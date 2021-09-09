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

      findChildLocation,
      UserFindUsId;
      double? latitude,longitude;
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
        this.findChildLocation,
      this.UserFindUsId,
      this.latitude,this.longitude,
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
      findChildLocation: json['findChildLocation'],
      UserFindUsId: json['UserFindUsId'],
      find: json['find'],
      // longitude: double.parse(json['longitude'].toString()),
      // latitude:double.parse(json['latitude'].toString()), 
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
      "findChildLocation" : findChildLocation,
      "UserFindUsId": UserFindUsId,
      "find": find,
      // 'latitude':latitude,
      // 'longitude':longitude

    };
  }
}
