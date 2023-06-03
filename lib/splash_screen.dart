import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multi_role_based_app/constants.dart';
import 'package:multi_role_based_app/home_admin.dart';
import 'package:multi_role_based_app/login_screen.dart';
import 'package:multi_role_based_app/student_view.dart';
import 'package:multi_role_based_app/teacher_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    // print('run');
    super.initState();
    isLogin();
  }

  void isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool? isLogin = sp.getBool('isLogin');
    String? userRole = sp.getString('role');

    if(isLogin == true){
     if(userRole == 'Admin'){
       Timer(const Duration(seconds: 3), () async {

         await Navigator.push(
             context, MaterialPageRoute(builder: (context) => const HomeAdmin()));
       });
     } else if (userRole == 'Teacher'){
       Timer(const Duration(seconds: 3), () async {

         await Navigator.push(
             context, MaterialPageRoute(builder: (context) => const TeacherView()));
       });
     }else{
       Timer(const Duration(seconds: 3), () async {

         await Navigator.push(
             context, MaterialPageRoute(builder: (context) => const StudentView()));
       });
     }
    }

    else{
      Timer(const Duration(seconds: 3), () async {

        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    // print('build');
    return const Scaffold(
        body: SafeArea(
      child: Image(
        height: double.maxFinite,
        image: NetworkImage(splashImage),
        fit: BoxFit.cover,
      ),
    ));
  }
}
