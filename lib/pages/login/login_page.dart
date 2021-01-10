import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import 'package:sail_app/models/login_model.dart';
import 'package:sail_app/models/user_model.dart';
import 'package:sail_app/service/user_service.dart';
import 'package:sail_app/utils/navigator_util.dart';
import 'package:sail_app/constant/app_strings.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  UserModel _userModel;
  LoginModel _loginModel;

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
    String result;

    try {
      await _loginModel.login(data.name, data.password);
    } catch (err) {
      result = '登陆失败，请重试';
    }

    return result;
  }

  Future<String> _register(LoginData data) async {
    String result;

    try {
      await UserService()
          .register({'email': data.name, 'password': data.password});

      await _loginModel.login(data.name, data.password);
    } catch (err) {
      result = '注册失败，请重试';
    }

    return result;
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    _userModel = Provider.of<UserModel>(context);
    _loginModel = LoginModel(_userModel);

    return FlutterLogin(
      title: AppStrings.APP_NAME,
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
        NavigatorUtil.goHomePage(context);
      },
      onRecoverPassword: _recoverPassword,
      emailValidator: _emailValidator,
      passwordValidator: _passwordValidator,
    );
  }
}
