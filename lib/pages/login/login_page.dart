import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:provider/provider.dart';
import 'package:sail/models/login_model.dart';
import 'package:sail/models/user_model.dart';
import 'package:sail/service/user_service.dart';
import 'package:sail/utils/navigator_util.dart';
import 'package:sail/constant/app_strings.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  Duration get loginTime => const Duration(milliseconds: 2250);

  late UserModel _userModel;
  late LoginModel _loginModel;

  static String? _emailValidator(value) {
    if (value.isEmpty || !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value)) {
      return '请输入正确邮箱!';
    }
    return null;
  }

  static String? _passwordValidator(String? value) {
    if (value?.isEmpty == true) {
      return '密码不能为空!';
    }
    if (value?.length == null || value!.length < 6) {
      return '密码不能小于6位';
    }
    return null;
  }

  Future<String?> _login(LoginData data) async {
    String? result;

    try {
      await _loginModel.login(data.name, data.password);
    } catch (error) {
      result = '登陆失败，请重试';
    }

    return result;
  }

  Future<String?> _register(SignupData data) async {
    String? result;

    try {
      await UserService().register({'email': data.name, 'password': data.password});

      await _loginModel.login(data.name, data.password);
    } catch (error) {
      result = '注册失败，请重试';
    }

    return result;
  }

  Future<String?> _recoverPassword(String name) {
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
          userHint: '邮箱',
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
      userValidator: _emailValidator,
      passwordValidator: _passwordValidator,
    );
  }
}
