import 'package:copyify/domain/entities/auth/user.dart';

class UserModel{
  String ? email;
  String ? fullName;
  String ? imageUrl;

  UserModel({
    this.email,
    this.imageUrl,
    this.fullName
  });

  UserModel.fromJson(Map<String, dynamic> data){
    email = data['email'];
    fullName = data['name'];
  }
}

extension UserModelX on UserModel{
  UserEntity toUserEnitiy() {
    return UserEntity(email: email, fullName: fullName, imageUrl: imageUrl);
  }
}