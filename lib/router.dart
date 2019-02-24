import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'homePage.dart';
import 'main.dart';

final routes = {
  '/':         (BuildContext context) => new SplashScreen(),
  '/home':         (BuildContext context) => new HomePage(),
  '/login' :          (BuildContext context) => new LoginPage(),
};