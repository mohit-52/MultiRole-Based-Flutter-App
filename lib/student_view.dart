import 'package:flutter/material.dart';
import 'package:multi_role_based_app/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentView extends StatefulWidget {
  const StudentView({Key? key}) : super(key: key);

  @override
  State<StudentView> createState() => _StudentViewState();
}

class _StudentViewState extends State<StudentView> {
  String username = '';
  String age = '';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData ()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    username = sp.getString('UserName')!;
    age = sp.getString('age')!;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student View"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text("Hi, $username\nYour age is: $age", style: const TextStyle(fontSize: 20),)),
          Center(
            child: InkWell(
              onTap: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.clear();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));

              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                height: 50,
                width: double.maxFinite,
                color: Colors.green,
                child: const Center(
                  child: Text("LogOut"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}
