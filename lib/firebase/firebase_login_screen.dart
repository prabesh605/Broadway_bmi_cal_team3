import 'package:broadway_bmi_cal/firebase/firbase_service.dart';
import 'package:broadway_bmi_cal/firebase/firebase_create_user_screen.dart';
import 'package:broadway_bmi_cal/firebase/firebase_product_screen.dart';
import 'package:broadway_bmi_cal/firebase/firebase_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseLoginScreen extends StatelessWidget {
  const FirebaseLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ApiService apiService = ApiService();
    FirbaseService firbaseService = FirbaseService();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.password),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                UserCredential userCredential = await firbaseService.signIn(
                  emailController.text,
                  passwordController.text,
                );

                if (userCredential.user != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FirebaseProductScreen(),
                    ),
                  );
                }
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const FirebaseScreen(),
                //   ),
                // );
              },
              child: Text("Login"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FirebaseCreateUserScreen(),
                  ),
                );
              },
              child: Text("Create new User"),
            ),
          ],
        ),
      ),
    );
  }
}
