// import 'package:biongoweb/bingo_game.dart';
// import 'package:biongoweb/data.dart';
// import 'package:biongoweb/screen/Admin/admin_screen.dart';
// import 'package:flutter/material.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20.0),
//           child: Card(
//             elevation: 3,
//             child: Padding(
//               padding: const EdgeInsets.all(35.0),
//               child: Container(
//                 constraints: BoxConstraints(maxWidth: 400),
//                 child: Column(
//                   spacing: 20,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Login',
//                       style:
//                           TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 20),
//                     TextField(
//                       controller: _phoneController,
//                       keyboardType: TextInputType.phone,
//                       decoration: InputDecoration(
//                         labelText: 'Phone Number',
//                         border: OutlineInputBorder(),
//                         prefixIcon: Icon(Icons.phone),
//                       ),
//                     ),
//                     TextField(
//                       obscureText: true,
//                       controller: _passwordController,
//                       decoration: InputDecoration(
//                         labelText: 'Password',
//                         border: OutlineInputBorder(),
//                         prefixIcon: Icon(Icons.lock),
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         handleLogin();
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.black,
//                         minimumSize: Size(double.infinity, 50),
//                         foregroundColor: Colors.white,
//                         overlayColor: Colors.grey,
//                       ),
//                       child: Text('Login'),
//                     ),
//                     const SizedBox(
//                       height: 25,
//                     )
//                     /
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:biongoweb/bingo_game.dart';
import 'package:biongoweb/data.dart';
import 'package:biongoweb/screen/Admin/admin_screen.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void handleLogin() {
    for (int i = 0; i < authList.length; i++) {
      if (authList[i]['phone'] == _phoneController.text &&
          authList[i]['password'] == _passwordController.text) {
        if (authList[i]['type'] == '1') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BingoGameScreen()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AdminScreen()),
          );
        }
      }
    }
  }

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                width: constraints.maxWidth > 700 ? 500 : double.infinity,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        TextField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.phone),
                          ),
                        ),
                        TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            handleLogin();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            minimumSize: Size(double.infinity, 50),
                            foregroundColor: Colors.white,
                            overlayColor: Colors.grey,
                          ),
                          child: Text('Login'),
                        ),
                        SizedBox(height: 20),
                        // TextButton(
                        //   onPressed: () {},
                        //   child: Text('Forgot Password?'),
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class BingoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bingo Game')),
      body: Center(child: Text('Welcome to Bingo Game')),
    );
  }
}

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard')),
      body: Center(child: Text('Welcome to Admin Dashboard')),
    );
  }
}
