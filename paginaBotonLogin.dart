import 'package:animate_do/animate_do.dart';
import 'package:app_firebase_v2/util/themeModeNotifier.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class paginaBotonLogin extends StatefulWidget {
  @override
  _paginaBotonLoginState createState() => _paginaBotonLoginState();
}

class _paginaBotonLoginState extends State<paginaBotonLogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool _isLoggedIn = false;
  GoogleSignInAccount? _googleUser;
  String? _userImageUrl;
  String? _userEmail;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  Future<void> _loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // El usuario canceló el inicio de sesión
        setState(() {
          _errorMessage = 'Inicio de sesión cancelado';
        });
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      setState(() {
        _isLoggedIn = true;
        _googleUser = googleUser;
        _userImageUrl = googleUser.photoUrl;
        _userEmail = user?.email;
        _errorMessage = '';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error durante el inicio de sesión: $e';
      });
    }
  }

  Future<void> _logout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    setState(() {
      _isLoggedIn = false;
      _googleUser = null;
      _userImageUrl = null;
      _userEmail = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoggedIn
        ? SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            height: 60,
            child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      // Change your radius here
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 0, 197, 102))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Stack(
                      children: [
                        _userImageUrl != null
                            ? ClipOval(
                                child: Image.network(
                                  _userImageUrl!,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: progress.expectedTotalBytes !=
                                                null
                                            ? progress.cumulativeBytesLoaded /
                                                progress.expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              )
                            : CircularProgressIndicator(),
                        Positioned.fill(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                // Acción al hacer clic en la imagen
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        'Sesion Iniciada',
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ZoomIn(
                          duration: const Duration(milliseconds: 250),
                          child: const FaIcon(FontAwesomeIcons.check)),
                    ],
                  ),
                ],
              ),
              onPressed: () {},
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              height: 60,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color?>(
                      Theme.of(context).brightness == Brightness.light
                          ? Colors.amber
                          : Colors.amber), // Cambia el color del botón aquí
                  elevation: MaterialStateProperty.all<double>(
                      0.0), // Cambia la elevación del botón aquí

                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Color.fromARGB(
                            255, 190, 143, 255); //<-- SEE HERE
                      return null; // Defer to the widget's default.
                    },
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Iniciar Sesion Con Google',
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                onPressed: () {
                  _loginWithGoogle().then((value) {
                    Future.delayed(const Duration(seconds: 1), () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    });
                  });
                },
              ),
            ),
          );
  }
}

// la idea principla es es hacer que el boton de inicio de sesion haga todo
