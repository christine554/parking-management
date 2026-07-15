import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grading Application"),
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
          IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset("assets/whatsapp image 2024-07-12 at 19.14.10_2ef949cf.jpg", width: 200, height: 200)],
            ),
            Text(
              "Username:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: .w300,
                color: Colors.deepOrangeAccent,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Password:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: .bold,
                color: Colors.deepOrangeAccent,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),

            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {
                    Get.toNamed("/home");
                  },
                  color: Colors.cyan,
                  height: 50,
                  minWidth: 200,
                  child: Text("Login"),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Text(
                    "Not registerd? Sign Up",
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                  onTap: () {
                    //code to navigate to SINGUP page
                    Get.toNamed("/signup");
                  },
                ),
                Spacer(),
                Text(
                  "Forgot Password? Reset",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}