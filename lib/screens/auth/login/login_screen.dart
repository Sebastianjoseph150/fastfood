import 'package:fastfood/screens/auth/signin/Signin_screen.dart';
import 'package:fastfood/screens/home_screen/Home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/authbloc/auth_bloc.dart';
import '../../../repository/auth_repository.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final AuthRepository authRepository = AuthRepository();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            AuthBloc(authRepository: authRepository, scaffoldKey: scaffoldKey),
        child: _buildLoginScreen(context),
      ),
    );
  }

  Widget _buildLoginScreen(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue, Colors.green],
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    height: 250,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Log in "),
                      const SizedBox(
                        width: 150,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignIn(),
                            ),
                          );
                        },
                        child: const Text(
                          "Signin",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email/username',
                          hintText: 'Enter your username',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email/username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(ForgetPassWordEvent(
                                  restetEmail: emailController.text,
                                  context: context));
                            },
                            child: const Text("Forgot Password"),
                          ),
                        ],
                      ),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              // if (state is! Loading) {
                              if (Form.of(context).validate()) {
                                context.read<AuthBloc>().add(
                                      SignInRequest(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        context: context,
                                      ),
                                    );

                                if (state is SignInSuccess) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const HomePage())));
                                } else if (state is LoginfailedState) {
                                  final scaffoldMessenger =
                                      ScaffoldMessenger.of(context);
                                  scaffoldMessenger.showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                          'failed to login check your user name and password '),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                }
                              }

                              // if (state is SignInSuccess) {
                              //   Navigator.pushReplacement(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: ((context) =>
                              //               const HomePage())));
                              // } else if (state is LoginfailedState) {
                              //   final scaffoldMessenger =
                              //       ScaffoldMessenger.of(context);
                              //   scaffoldMessenger.showSnackBar(
                              //     const SnackBar(
                              //       backgroundColor: Colors.red,
                              //       content: Text(
                              //           'failed to login check your user name and password '),
                              //       duration: Duration(seconds: 2),
                              //     ),
                              //   );
                              // }
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 50),
                              ),
                            ),
                            child: state is Loading
                                ? const CircularProgressIndicator()
                                : const Text("Login"),
                          );
                        },
                      ),
                      // BlocListener<AuthBloc, AuthState>(
                      //   listener: (context, state) {
                      //     if (state is SignInSuccess) {
                      //       Navigator.pushReplacement(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => const HomePage()),
                      //       );
                      //     } else if (state is LoginfailedState) {
                      //       final scaffoldMessenger =
                      //           ScaffoldMessenger.of(context);
                      //       scaffoldMessenger.showSnackBar(
                      //         const SnackBar(
                      //           backgroundColor: Colors.red,
                      //           content: Text(
                      //               'Failed to login, check your username and password.'),
                      //           duration: Duration(seconds: 2),
                      //         ),
                      //       );
                      //     }
                      //   },
                      //   child: ElevatedButton(
                      //     onPressed: () {
                      //       if (Form.of(context).validate()) {
                      //         context.read<AuthBloc>().add(
                      //               SignInRequest(
                      //                 email: emailController.text,
                      //                 password: passwordController.text,
                      //                 context: context,
                      //               ),
                      //             );
                      //       }
                      //     },
                      //     style: ButtonStyle(
                      //       minimumSize: MaterialStateProperty.all(
                      //         const Size(double.infinity, 50),
                      //       ),
                      //     ),
                      //     child: BlocBuilder<AuthBloc, AuthState>(
                      //       builder: (context, state) {
                      //         return state is Loading
                      //             ? const CircularProgressIndicator()
                      //             : const Text("Login");
                      //       },
                      //     ),
                      //   ),
                      // ),

                      const SizedBox(
                        height: 10,
                      ),
                      const Text("or"),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 50),
                          ),
                        ),
                        child: const Text("Login with Google"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
