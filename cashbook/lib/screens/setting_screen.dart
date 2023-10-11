import 'package:cashbook/screens/login_screen.dart';
import 'package:cashbook/styles/constant.dart';
import 'package:cashbook/utilities/db_helper.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  final int? userId;

  const SettingScreen({Key? key, this.userId}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  String errorMessage = '';
  var oldPasswordColor = foregroundColor;
  var newPasswordColor = foregroundColor;

  void _refreshScreen(
      String errorMessage, var oldPasswordColor, var newPasswordColor) async {
    setState(() {
      this.errorMessage = errorMessage;
      this.oldPasswordColor = oldPasswordColor;
      this.newPasswordColor = newPasswordColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: primaryColor,
              height: MediaQuery.of(context).size.height * .14,
              child: Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 56),
                    child: Center(
                      child: Text(
                        'Pengaturan',
                        style: TextStyle(
                          fontSize: 20,
                          color: whiteColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8, top: 56),
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 56, 14, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        bottom: 16,
                      ),
                      child: Text(
                        'Ganti Password',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: oldPasswordColor,
                        ),
                      ),
                      child: TextFormField(
                        obscureText: true,
                        cursorColor: primaryColor,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _oldPasswordController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.lock,
                            color: oldPasswordColor,
                          ),
                          hintText: 'Password lama',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: newPasswordColor,
                        ),
                      ),
                      child: TextFormField(
                        obscureText: true,
                        cursorColor: primaryColor,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _newPasswordController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.lock,
                            color: newPasswordColor,
                          ),
                          hintText: 'Password baru',
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await _changePassword();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: const Color.fromARGB(255, 122, 77, 9),
                        ),
                        margin: const EdgeInsets.only(top: 12),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 28,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Simpan',
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Center(
                        child: Text(
                          errorMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false,
                        )
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: dangerColor,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 28,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/profile.jpg',
                            width: 144,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 16,
                              ),
                              child: Text(
                                'About this App..',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                'Aplikasi ini dibuat oleh:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 4.0),
                              child: Text('Nama: Zulfia Lutfiani'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 4.0),
                              child: Text('NIM: 2141764000'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 4.0),
                              child: Text('Tanggal: 30 September 2023'),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _changePassword() async {
    var state = await DbHelper.changePassword(
      int.parse(widget.userId.toString()),
      _oldPasswordController.text,
      _newPasswordController.text,
    );

    if (state) {
      _refreshScreen('', foregroundColor, foregroundColor);
    } else if (_oldPasswordController.text == '' &&
        _newPasswordController.text == '') {
      _refreshScreen('Semua field harus di isi!', dangerColor, dangerColor);
    } else if (_oldPasswordController.text == '') {
      _refreshScreen(
          'Password lama harus di isi!', dangerColor, foregroundColor);
    } else if (_newPasswordController.text == '') {
      _refreshScreen(
          'Password baru harus di isi!', foregroundColor, dangerColor);
    } else {
      _refreshScreen('Password lama salah', dangerColor, foregroundColor);
    }
  }
}
