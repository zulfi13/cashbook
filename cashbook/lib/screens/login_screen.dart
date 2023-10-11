import 'package:cashbook/screens/home_screen.dart';
import 'package:cashbook/styles/constant.dart';
import 'package:cashbook/utilities/db_helper.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String errorMessage = '';
  var usernameColor = foregroundColor;
  var passwordColor = foregroundColor;

  void _refreshScreen(
      String errorMessage, var usernameColor, var passwordColor) async {
    setState(() {
      this.errorMessage = errorMessage;
      this.usernameColor = usernameColor;
      this.passwordColor = passwordColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double defaultLoginSize = size.height - (size.height * 0.2);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            height: defaultLoginSize,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 190,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Buku Kas',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: secondaryColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 32,
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          // color: const Color(0xFFD6E4FF).withAlpha(144),
                          border: Border.all(
                            color: usernameColor,
                          ),
                        ),
                        child: TextFormField(
                          cursorColor: primaryColor,
                          keyboardType: TextInputType.text,
                          controller: _usernameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.person,
                              color: usernameColor,
                            ),
                            hintText: 'Username',
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          // color: const Color(0xFFD6E4FF).withAlpha(144),
                          border: Border.all(
                            color: passwordColor,
                          ),
                        ),
                        child: TextFormField(
                          cursorColor: primaryColor,
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock,
                              color: passwordColor,
                            ),
                            hintText: 'Password',
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await _login();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: secondaryColor,
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          alignment: Alignment.center,
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.25,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        errorMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    var state = await DbHelper.login(
      _usernameController.text,
      _passwordController.text,
    );

    if (state.isNotEmpty) {
      _refreshScreen('', foregroundColor, foregroundColor);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            userId: state[0]['id'],
          ),
        ),
        (route) => false,
      );
    } else if (_usernameController.text == '' &&
        _passwordController.text == '') {
      _refreshScreen(
          'Username dan password harus di isi!', dangerColor, dangerColor);
    } else if (_usernameController.text == '') {
      _refreshScreen('Username harus di isi!', dangerColor, foregroundColor);
    } else if (_passwordController.text == '') {
      _refreshScreen('Password harus di isi!', foregroundColor, dangerColor);
    } else {
      _refreshScreen(
        'Login gagal, pastikan username atau password yang Anda masukkan sudah benar!',
        foregroundColor,
        foregroundColor,
      );
    }
  }
}
