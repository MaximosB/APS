// import 'package:acamp_kids/Screens/login.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';

// class LoginFacebook extends StatefulWidget {
//   @override
//   _LoginFacebookState createState() => _LoginFacebookState();
// }

// class _LoginFacebookState extends State<LoginFacebook> {
//   bool _isLogged = false;

//   var facebookLogin = FacebookLogin();

//   var profileData;

//   get http => null;
//   void onloginStatusChanged(bool isLogged, {profileData}) {
//     setState(() {
//       _isLogged = isLogged;
//       profileData = profileData;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('App'),
//       ),
//       body: Container(
//         child:
//             _isLogged ? _displayUserData(profileData) : _displayLoginButton(),
//       ),
//     );
//   }

//   _displayLoginButton() {
//     return ElevatedButton(
//       child: Text("Login with Facebook"),
//       onPressed: () => initiateFacebookLogin(),
//     );
//   }

//   void initiateFacebookLogin() async {
//     var facebookLoginResult = await facebookLogin.logIn(['email']);

//     switch (facebookLoginResult.status) {
//       case FacebookLoginStatus.error:
//         onloginStatusChanged(false);
//         break;
//       case FacebookLoginStatus.cancelledByUser:
//         onloginStatusChanged(false);
//         break;
//       case FacebookLoginStatus.loggedIn:
//         FacebookAuth.instance
//             .login(permissions: ["public_profile", "email"]).then((value) {
//           FacebookAuth.instance.getUserData().then((userdata) {
//             setState(() {
//               _isLogged = true;
//               profileData = userdata;
//             });
//             _displayUserData(profileData);
//           });
//         });
//         onloginStatusChanged(_isLogged, profileData: profileData);
//         break;
//     }
//   }

//   _displayUserData(profileData) {
//     return Container(
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.network(profileData['picture']['data']['url']),
//             Text(profileData['name'] ?? 'O nome não veio'),
//             Text(profileData["email"] ?? 'O nome não veio'),
//             SizedBox(
//               height: 30.0,
//             ),
//             TextButton(
//                 onPressed: () {
//                   _logout();
//                 },
//                 child: Text("Logout"))
//           ],
//         ),
//       ),
//     );
//   }

//   _logout() async {
//     await facebookLogin.logOut();
//     onloginStatusChanged(false);
//     print("Logged Out");
//     Navigator.push(context, MaterialPageRoute(builder: (c) => Login()));
//   }
// }
//
// import 'package:acamp_kids/login.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
//
// class LoginFacebook {
//   bool _isLogged = false;
//
//   var facebookLogin = FacebookLogin();
//
//   var profileData;
//
//   // get http => null;
//
//   void onloginStatusChanged(bool isLogged, {profileData}) {
//     _isLogged = isLogged;
//     profileData = profileData;
//   }
//
//   Widget _displayLoginButton() {
//     return ElevatedButton(
//       child: Text("Login with Facebook"),
//       onPressed: () => initiateFacebookLogin(),
//     );
//   }
//
//   Widget _displayUserData(profileData) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Logged'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.network(profileData['picture']['data']['url']),
//             Text(profileData['name'] ?? 'O nome não veio'),
//             Text(profileData["email"] ?? 'O nome não veio'),
//             SizedBox(
//               height: 30.0,
//             ),
//             TextButton(
//                 onPressed: () {
//                   _logout();
//                 },
//                 child: Text("Logout"))
//           ],
//         ),
//       ),
//     );
//   }
//
//   void initiateFacebookLogin() async {
//     var facebookLoginResult = await facebookLogin.logIn(['email']);
//
//     switch (facebookLoginResult.status) {
//       case FacebookLoginStatus.error:
//         onloginStatusChanged(false);
//         break;
//       case FacebookLoginStatus.cancelledByUser:
//         onloginStatusChanged(false);
//         break;
//       case FacebookLoginStatus.loggedIn:
//         FacebookAuth.instance
//             .login(permissions: ["public_profile", "email"]).then((value) {
//           FacebookAuth.instance.getUserData().then((userdata) {
//             _isLogged = true;
//             profileData = userdata;
//             _displayUserData(profileData);
//             // setState(() {
//
//             // });
//           });
//         });
//         print(profileData);
//         onloginStatusChanged(_isLogged, profileData: profileData);
//         break;
//     }
//   }
//
//   _logout() async {
//     await facebookLogin.logOut();
//     onloginStatusChanged(false);
//     print("Logged Out");
//     Login();
//   }
// }
