// import 'package:flutter/material.dart';
// import 'package:fastfood/repository/auth_repository.dart';

// class SignIn extends StatelessWidget {
//   SignIn({Key? key}) : super(key: key);
//   final signup = AuthRepository();
//   final _formkey = GlobalKey<FormState>();

//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(20),
//                   bottomRight: Radius.circular(20),
//                 ),
//                 gradient: LinearGradient(
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                   colors: [Colors.blue, Colors.green], // Gradient colors
//                 ),
//               ),
//               child: Center(
//                 child: Column(
//                   children: [
//                     Image.asset(
//                       "assets/images/logo.png",
//                       height: 250,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text("Sign in "),
//                         SizedBox(
//                           width: 150,
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             // Add navigation logic here (e.g., back to the login page)
//                             Navigator.pop(context);
//                           },
//                           child: Text(
//                             "Back to Login",
//                             style: TextStyle(
//                               color: Colors.white, // Text color
//                             ),
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Container(
//                   padding: EdgeInsets.all(16.0),
//                   child: Form(
//                     key: _formkey,
//                     child: Column(
//                       children: [
//                         TextFormField(
//                           controller: nameController,
//                           decoration: InputDecoration(
//                             labelText: 'Username',
//                             hintText: 'Enter your username',
//                             prefixIcon: Icon(Icons.person),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                           validator: (value) => null,
//                         ),
//                         SizedBox(height: 16.0),
//                         TextFormField(
//                           controller: passwordController,
//                           decoration: InputDecoration(
//                             labelText: 'Password',
//                             hintText: 'Enter your password',
//                             prefixIcon: Icon(Icons.lock),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                           obscureText: true,
//                         ),
//                         SizedBox(height: 16.0),
//                         TextFormField(
//                           controller: emailController,
//                           decoration: InputDecoration(
//                             labelText: 'Email',
//                             hintText: 'Enter your email',
//                             prefixIcon: Icon(Icons.email),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                           validator: (value) => null,
//                         ),
//                         SizedBox(height: 16.0),
//                         TextFormField(
//                           controller: phoneController,
//                           decoration: InputDecoration(
//                             labelText: 'Phone Number',
//                             hintText: 'Enter your phone number',
//                             prefixIcon: Icon(Icons.phone),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                           ),
//                           validator: (value) => null,
//                         ),
//                         SizedBox(height: 16.0),
//                         ElevatedButton(
//                           onPressed: () {
//                             signup.signUp(
//                                 email: emailController.text,
//                                 password: passwordController.text);
//                           },
//                           child: Text("Sign In"),
//                           style: ButtonStyle(
//                             minimumSize: MaterialStateProperty.all(
//                               Size(double.infinity, 50),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//   // Add a meth
// }
import 'package:fastfood/bloc/authbloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fastfood/repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);
  final signup = AuthRepository();
  final _formkey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    // You can add more complex email validation logic here if needed
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    // You can add more complex password validation logic here if needed
    return null;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    // You can add more complex username validation logic here if needed
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    // You can add more complex phone number validation logic here if needed
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  colors: [Colors.blue, Colors.green], // Gradient colors
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
                        const Text("Sign in "),
                        const SizedBox(
                          width: 150,
                        ),
                        TextButton(
                          onPressed: () {
                            // Add navigation logic here (e.g., back to the login page)
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Back to Login",
                            style: TextStyle(
                              color: Colors.white, // Text color
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
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            hintText: 'Enter your username',
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator:
                              validateUsername, // Use the username validator
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
                          validator:
                              validatePassword, // Use the password validator
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            prefixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: validateEmail, // Use the email validator
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            hintText: 'Enter your phone number',
                            prefixIcon: const Icon(Icons.phone),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator:
                              validatePhoneNumber, // Use the phone number validator
                        ),
                        const SizedBox(height: 16.0),
                        BlocListener<AuthBloc, AuthState>(
                          listener: (context, state) {
                            if (state is SignUpSuccess) {
                              final scaffoldMessenger =
                                  ScaffoldMessenger.of(context);
                              scaffoldMessenger.showSnackBar(
                                const SnackBar(
                                  content: Text('User registered successfully'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                              // You can also navigate to another page or perform other actions here
                            } else if (state is SignUpFailure) {
                              print('hiiiiii');
                              final scaffoldMessenger =
                                  ScaffoldMessenger.of(context);
                              scaffoldMessenger.showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                      'Not able to register. Check the details'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formkey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                      SignUpRequested(
                                        email: emailController.text,
                                        name: nameController.text,
                                        password: passwordController.text,
                                      ),
                                    );
                              }
                            },
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                const Size(double.infinity, 50),
                              ),
                            ),
                            child: const Text("Sign In"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
