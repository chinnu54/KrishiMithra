class UserDetails {
  // final String id;
  final String name;
  final String email;
  final String state;
  final String city;
  final String crop;
  final String district;

  UserDetails({
    // required this.id,
    required this.name,
    required this.email,
    required this.state,
    required this.city,
    required this.district,
    required this.crop,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'id': id,
      'name': name,
      'email': email,
      'state': state,
      'city': city,
      'district':district,
      'crop': crop,
    };
  }

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(

      // id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      state: map['state'] ?? '',
      city: map['city'] ?? '',
      district: map['district']??'',
      crop: map['crop'] ?? '',

    );
  }
//   @override
//   String toString() {
//     return 'UserDetails{name: $name, email: $email}';
//   }
// }



  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'state': state,
      'city': city,
      'district':district,
      'crop': crop,
    };
  }

  // Create UserDetails from JSON
  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      district:json['district'] ?? '',
      crop: json['crop'] ?? '',
    );
  }

  // Optional: For debugging purposes
  @override
  String toString() {
    return 'UserDetails{name: $name, email: $email, state: $state, city: $city, district: $district, crop: $crop}';
  }
}