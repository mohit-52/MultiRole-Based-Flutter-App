import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multi_role_based_app/home_admin.dart';
import 'package:multi_role_based_app/student_view.dart';
import 'package:multi_role_based_app/teacher_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();

  // Initial Selected Value
  String selectedRole = 'Student';

  // List of roles in our dropdown menu
  var items = [
    'Admin',
    'Student',
    'Teacher',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(hintText: "UserName"),
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(hintText: "Password"),
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: "Age"),
              ),
              const SizedBox(
                height: 40,
              ),
              DropdownButtonFormField(

                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:  const Color(0x00001c3c).withOpacity(0.9), width: 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color:  const Color(0x00001c3c).withOpacity(0.9), width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                // Initial Value
                value: selectedRole,

                // Down Arrow Icon
                icon: const Icon(Icons.arrow_drop_down),

                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedRole = newValue!;
                  });
                },
              ),

             const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () async {
                  SharedPreferences sp = await SharedPreferences.getInstance();
                  sp.setString('UserName', emailController.text.toString());
                  sp.setString('age', ageController.text.toString());
                  sp.setBool('isLogin', true);
                  sp.setString('role', selectedRole.toString());

                  if(selectedRole == 'Admin'){
                    Timer(const Duration(seconds: 0), () async {

                      await Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const HomeAdmin()));
                    });
                  } else if (selectedRole == 'Teacher'){
                    Timer(const Duration(seconds: 0), () async {

                      await Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const TeacherView()));
                    });
                  }else{
                    Timer(const Duration(seconds: 0), () async {

                      await Navigator.push(
                          context, MaterialPageRoute(builder: (context) => const StudentView()));
                    });
                  }

                },
                child: Container(
                  height: 50,
                  width: double.maxFinite,
                  color: Colors.green,
                  child: const Center(
                    child: Text("LogIn"),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
