class UserModel {
  final String email;
  final String username;
  final String userid;
  final String profileImage;
  final String bio;
  final String fcmToken;
  final bool isSeller;
  final String lat;
  final String long;

//<editor-fold desc="Data Methods">
  const UserModel({
    required this.email,
    required this.username,
    required this.userid,
    required this.profileImage,
    required this.bio,
    required this.fcmToken,
    required this.isSeller,
    required this.lat,
    required this.long,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserModel &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          username == other.username &&
          userid == other.userid &&
          profileImage == other.profileImage &&
          bio == other.bio &&
          fcmToken == other.fcmToken &&
          isSeller == other.isSeller &&
          lat == other.lat &&
          long == other.long);

  @override
  int get hashCode =>
      email.hashCode ^
      username.hashCode ^
      userid.hashCode ^
      profileImage.hashCode ^
      bio.hashCode ^
      fcmToken.hashCode ^
      isSeller.hashCode ^
      lat.hashCode ^
      long.hashCode;

  @override
  String toString() {
    return 'UserModel{' +
        ' email: $email,' +
        ' username: $username,' +
        ' userid: $userid,' +
        ' profileImage: $profileImage,' +
        ' bio: $bio,' +
        ' fcmToken: $fcmToken,' +
        ' isSeller: $isSeller,' +
        ' lat: $lat,' +
        ' long: $long,' +
        '}';
  }

  UserModel copyWith({
    String? email,
    String? username,
    String? userid,
    String? profileImage,
    String? bio,
    String? fcmToken,
    bool? isSeller,
    String? lat,
    String? long,
  }) {
    return UserModel(
      email: email ?? this.email,
      username: username ?? this.username,
      userid: userid ?? this.userid,
      profileImage: profileImage ?? this.profileImage,
      bio: bio ?? this.bio,
      fcmToken: fcmToken ?? this.fcmToken,
      isSeller: isSeller ?? this.isSeller,
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'username': this.username,
      'userid': this.userid,
      'profileImage': this.profileImage,
      'bio': this.bio,
      'fcmToken': this.fcmToken,
      'isSeller': this.isSeller,
      'lat': this.lat,
      'long': this.long,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      username: map['username'] as String,
      userid: map['userid'] as String,
      profileImage: map['profileImage'] as String,
      bio: map['bio'] as String,
      fcmToken: map['fcmToken'] as String,
      isSeller: map['isSeller'] as bool,
      lat: map['lat'] as String,
      long: map['long'] as String,
    );
  }

//</editor-fold>
}
