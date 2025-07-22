import 'package:fastnotes_bloc/core/constants/api_constants.dart';
import 'package:fastnotes_bloc/core/network/api_client.dart';
import 'package:fastnotes_bloc/features/auth/data/models/auth_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel?> login();
  Future<AuthModel?> refreshToken(String refreshToken);
  Future<GoogleSignInAccount?> getLoggedInUser();
  Future<bool> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDataSourceImpl(this._apiClient)
    : _googleSignIn = GoogleSignIn(
        serverClientId: dotenv.env['GOOGLE_SERVER_CLIENT_ID'],
        scopes: ['email', 'profile'],
      );

  @override
  Future<AuthModel?> login() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return null;
    }

    final googleAuth = await googleUser.authentication;

    if (googleAuth.idToken == null) {
      return null;
    }

    final response = await _apiClient.post(
      ApiConstants.login,
      data: {'idToken': googleAuth.idToken},
    );

    if (response != null) {
      return AuthModel.fromJson(response);
    }

    return null;
  }

  @override
  Future<GoogleSignInAccount?> getLoggedInUser() async {
    final user = _googleSignIn.currentUser;
    if (user == null) {
      return null;
    }
    return user;
  }

  @override
  Future<AuthModel?> refreshToken(String refreshToken) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future<bool> signOut() async {
    try {
      await _googleSignIn.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}
