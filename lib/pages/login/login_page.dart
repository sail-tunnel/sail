import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import 'package:sail_app/service/user_service.dart';
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

  static final FormFieldValidator<String> _emailValidator = (value) {
    if (value.isEmpty ||
        !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value)) {
      return '邮箱错误!';
    }
    return null;
  };

  static final FormFieldValidator<String> _passwordValidator = (value) {
    if (value.isEmpty) {
      return '密码不能为空!';
    }
    if (value.length < 6) {
      return '密码不能小于6位';
    }
    return null;
  };


  Future<String> _login(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');

    String result;

    try {
      await _loginViewModel.login(data.name, data.password);
    } catch (err) {
      result = '登陆失败，请重试';
    }

    return result;
  }

  Future<String> _register(LoginData data) async {
    print('Name: ${data.name}, Password: ${data.password}');

    String result;

    try {
      await UserService()
          .register({'email': data.name, 'password': data.password});

      await _loginViewModel.login(data.name, data.password);
    } catch (err) {
      result = '注册失败，请重试';
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

    if (_userViewModel.isLogin) {
      NavigatorUtil.goMainPage(context);
    }

    return FlutterLogin(
      title: AppStrings.APP_NAME,
      logo: 'assets/usa.png',
      onLogin: _login,
      onSignup: _register,
      messages: LoginMessages(
          usernameHint: '邮箱',
          passwordHint: '密码',
          confirmPasswordHint: '确认密码',
          confirmPasswordError: '两次密码不匹配',
          forgotPasswordButton: '忘记密码？',
          loginButton: '登陆',
          signupButton: '注册',
          recoverPasswordIntro: '重置密码',
          recoverPasswordButton: '确定',
          recoverPasswordDescription: '系统将向您的邮箱发送一封重置密码邮件，请注意查收',
          recoverPasswordSuccess: '发送成功',
          goBackButton: '返回'),
      onSubmitAnimationCompleted: () {
        NavigatorUtil.goMainPage(context);
      },
      onRecoverPassword: _recoverPassword,
      emailValidator: _emailValidator,
      passwordValidator: _passwordValidator,
    );
  }
}
