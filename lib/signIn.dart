// import 'package:dogfinder/ourservice.dart';
// import 'package:flutter/material.dart';

// class SignInScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       resizeToAvoidBottomInset: true,
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Logo
//               Column(
//                 children: [
//                   Image.asset('assets/images/logo.jpeg', height: 200, width: 200),
//                 ],
//               ),
//               Text(
//                 'Sign in',
//                 style: TextStyle(
//                   fontSize: 45,
//                   fontWeight: FontWeight.bold,
//                   color: Color.fromARGB(255, 32, 48, 89),
//                 ),
//               ),
//               SizedBox(height: 20),
//               // Social media buttons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: () {},
//                     icon: Icon(Icons.g_translate,color: Colors.white),
//                     label: Text('With Google',style: TextStyle(color: Colors.white),),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color.fromARGB(255, 104, 167, 219),
//                       padding: EdgeInsets.symmetric(horizontal: 40),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               // SizedBox(height: 20),
//               // Divider
//               Text('Or with Email'),
//               SizedBox(height: 40),
//               // Email field
//               TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Your Email',
//                   labelStyle: TextStyle(color: Colors.black),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Color.fromARGB(255, 104, 167, 219)),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               // Password field
//               TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   labelStyle: TextStyle(color: Colors.black),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Color.fromARGB(255, 104, 167, 219)),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   suffixIcon: TextButton(
//                     onPressed: () {},
//                     child: Text(
//                       'Forgot?',
//                       style: TextStyle(color: Color.fromARGB(255, 104, 167, 219)),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 60),
//               // Sign up text
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('New User? '),
//                   Text(
//                     'No Problem',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//               // SizedBox(height: 20),
//               // Sign up button
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => OurServicesScreen()), // Replace with your SignInScreen widget
//                       );
//                 },
//                 child: Text('Sign Up',style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color.fromARGB(255, 104, 167, 219),
//                   padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                     side: BorderSide(color: Color.fromARGB(255, 104, 167, 219)),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dogfinder/ourservice.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', _emailController.text);
      await prefs.setString('password', _passwordController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign Up Successful!')),
      );

      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OurServicesScreen()),
        );
      });
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final RegExp emailRegex = RegExp(
        r'^[a-zA-Z0-9]+([._%+-]?[a-zA-Z0-9]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z]{2,})+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset('assets/images/logo.png', height: 200, width: 200),
                  ],
                ),
                Text(
                  'Sign in',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 32, 48, 89),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.g_translate, color: Colors.white),
                      label: Text('With Google', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 104, 167, 219),
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
                Text('Or with Email'),
                SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Your Email',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 104, 167, 219)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: _validateEmail,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromARGB(255, 104, 167, 219)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot?',
                        style: TextStyle(color: Color.fromARGB(255, 104, 167, 219)),
                      ),
                    ),
                  ),
                  validator: _validatePassword,
                ),
                SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('New User? '),
                    Text(
                      'No Problem',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: _signUp,
                  child: Text('Sign Up', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 104, 167, 219),
                    padding: EdgeInsets.symmetric(horizontal: 120, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Color.fromARGB(255, 104, 167, 219)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
