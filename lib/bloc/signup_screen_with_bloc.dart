import 'package:broadway_bmi_cal/bloc/login_bloc/login_bloc.dart';
import 'package:broadway_bmi_cal/bloc/login_bloc/login_event.dart';
import 'package:broadway_bmi_cal/bloc/login_bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreenWithBloc extends StatelessWidget {
  const SignupScreenWithBloc({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text("SignUp")),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
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
                  SignUp(
                    nameController.text,
                    emailController.text,
                    passwordController.text,
                  ),
                );
                // context.read<LoginBloc>().add(Logout());
              },
              child: Text("SignUp"),
            ),
            BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginLoading) {
                  return CircularProgressIndicator();
                } else if (state is LoginError) {
                  return Text(state.error);
                } else if (state is SignUpSuccess) {
                  return Text("${state.name} email is ${state.email}");
                } else if (state is LogoutState) {
                  return Text("user is logout");
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
