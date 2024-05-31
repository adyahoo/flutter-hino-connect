part of 'i_use_case.dart';

abstract class IUserUseCase {
  Future<void> login(LoginBody body);

  Future<void> logout();

  Future<UserModel> getUser();
}
