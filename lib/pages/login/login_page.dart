import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import 'package:sail_app/models/login_model.dart';
import 'package:sail_app/models/user_model.dart';
import 'package:sail_app/service/user_service.dart';
import 'package:sail_app/utils/navigator_util.dart';
import 'package:sail_app/constant/app_strings.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  Duration get loginTime => const Duration(milliseconds: 2250);

  UserModel _userModel;
  LoginModel _loginModel;

  static String _emailValidator(value) {
    if (value.isEmpty || !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value)) {
      return 'Email error!';
    }
    return null;
  }

  static String _passwordValidator(String value) {
    if (value.isEmpty) {
      return 'password can not be blank!';
    }
    if (value.length < 6) {
      return 'Password cannot be less than 6 characters';
    }
    return null;
  }

  Future<String> _login(LoginData data) async {
    String result;

    try {
      await _loginModel.login(data.name, data.password);
    } catch (error) {
      result = error?.response?.data['message'].toString() ?? 'failed to login，Please try again';
    }

    return result;
  }

  Future<String> _register(LoginData data) async {
    String result;

    try {
      await UserService().register({'email': data.name, 'password': data.password});

      await _loginModel.login(data.name, data.password);
    } catch (error) {
      result = error?.response?.data['message'].toString() ?? 'registration failed，Please try again';
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
      title: AppStrings.appName,
      onLogin: _login,
      onSignup: _register,
      messages: LoginMessages(
          usernameHint: 'Mail',
          passwordHint: 'password',
          confirmPasswordHint: 'Confirm Password',
          confirmPasswordError: 'Password does not match twice',
          forgotPasswordButton: 'Forgot password？',
          loginButton: 'login',
          signupButton: 'register',
          recoverPasswordIntro: 'reset Password',
          recoverPasswordButton: 'Sure',
          recoverPasswordDescription: 'The system will send a reset password email to your mailbox, please pay attention to check',
          recoverPasswordSuccess: 'Sent successfully',
          goBackButton: 'return'),
      onSubmitAnimationCompleted: () {
        NavigatorUtil.goHomePage(context);
      },
      onRecoverPassword: _recoverPassword,
      emailValidator: _emailValidator,
      passwordValidator: _passwordValidator,
    );
  }
}
