import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart';

class HomeLocalizations {
  static Future<HomeLocalizations> load(Locale locale) {
    final String name = locale.countryCode?.isEmpty == true ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return HomeLocalizations();
    });
  }

  static HomeLocalizations? of(BuildContext context) {
    return Localizations.of<HomeLocalizations>(context, HomeLocalizations);
  }

  String get title {
    return Intl.message(
      'Flutter APP',
      name: 'title',
      desc: 'Title for the Demo application',
    );
  }
}

//Locale代理类
class HomeLocalizationsDelegate extends LocalizationsDelegate<HomeLocalizations> {
  const HomeLocalizationsDelegate();

  //是否支持某个Local
  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  // Flutter会调用此类加载相应的Locale资源类
  @override
  Future<HomeLocalizations> load(Locale locale) {
    return  HomeLocalizations.load(locale);
  }

  // 当Localizations Widget重新build时，是否调用load重新加载Locale资源.
  @override
  bool shouldReload(HomeLocalizationsDelegate old) => false;
}
