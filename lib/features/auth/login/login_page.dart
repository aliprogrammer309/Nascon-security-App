import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nascon_security_app/core/form_submission_status.dart';
import 'package:nascon_security_app/features/auth/login/bloc/login_bloc.dart';
import 'package:nascon_security_app/features/auth/login/bloc/login_event.dart';
import 'package:nascon_security_app/features/auth/login/bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, state) {
        if (state is ErrorLoginState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(state.error),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const SizedBox(height: 20),
            Text('Email', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 10),
            TextField(
              controller: email,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              onChanged: (email) {
                context.read<LoginBloc>().add(UpdateEmail(email: email));
              },
            ),
            const SizedBox(height: 20),
            Text('Password', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 10),
            TextField(
              controller: password,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (password) {
                context
                    .read<LoginBloc>()
                    .add(UpdatePassword(password: password));
              },
            ),
            const SizedBox(height: 40),
            BlocSelector<LoginBloc, LoginState, FormSubmissionState>(
              selector: (state) {
                if (state is LoginStateImp) {
                  return state.formState;
                } else {
                  return InitialFormSubmissionState();
                }
              },
              builder: (context, formState) {
                return formState is LoadingFormSubmissionState
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<LoginBloc>().add(LoginClicked());
                            email.clear();
                            password.clear();
                          },
                          child: const Text('Login'),
                        ),
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
