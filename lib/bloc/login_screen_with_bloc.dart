import 'package:broadway_bmi_cal/bloc/login_bloc/login_bloc.dart';
import 'package:broadway_bmi_cal/bloc/login_bloc/login_event.dart';
import 'package:broadway_bmi_cal/bloc/login_bloc/login_state.dart';
import 'package:broadway_bmi_cal/bloc/signup_screen_with_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreenWithBloc extends StatelessWidget {
  const LoginScreenWithBloc({super.key});

  @override
  Widget build(BuildContext context) {
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
                context.read<LoginBloc>().add(
                  Login(emailController.text, passwordController.text),
                );
              },
              child: Text("Login"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignupScreenWithBloc(),
                  ),
                );
              },
              child: Text("Signup"),
            ),

            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginLoading) {
                  return CircularProgressIndicator();
                } else if (state is LoginError) {
                  return Text("Email or Password not matched");
                } else if (state is Success) {
                  return Text("Success");
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
