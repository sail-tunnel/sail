import 'dart:core' as core;

import 'package:flutter/foundation.dart';

void print (core.Object object) {
  if (kDebugMode) {
    core.print(object);
  }
}
