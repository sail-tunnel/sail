import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import 'package:sail_app/utils/navigator_util.dart';
import 'package:sail_app/constant/app_strings.dart';
import 'package:sail_app/view_model/login_view_model.dart';
import 'package:sail_app/view_model/user_view_model.dart';

const users = const {
  'losgif@gmail.com': '12345',
};

class LoginPage extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  UserViewModel _userViewModel;
  LoginViewModel _loginViewModel;

  Future<String> _authUser(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');

    String result;

    try {
      await _loginViewModel.login(data.name, data.password);
    } catch (err) {
      result = '登陆失败，请重试';
    }

    return result;
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'Username not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    _userViewModel = Provider.of<UserViewModel>(context);
    _loginViewModel = LoginViewModel(_userViewModel);

    return FlutterLogin(
      title: AppStrings.APP_NAME,
      logo: 'assets/usa.png',
      onLogin: _authUser,
      onSignup: _authUser,
      onSubmitAnimationCompleted: () {
        NavigatorUtil.goMallMainPage(context);
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
