import 'package:easy_commerce/auth/domain/entities/user.dart';

class UserRepository {
  User _user;
  User get getUser => _user;
  set setUser(User user) {
    _user = user;
  }
}
