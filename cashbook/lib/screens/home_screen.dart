import 'package:cashbook/routes/routes.dart';
import 'package:cashbook/screens/setting_screen.dart';
import 'package:cashbook/styles/constant.dart';
import 'package:cashbook/utilities/currency_format.dart';
import 'package:cashbook/utilities/db_helper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final int? userId;
  const HomeScreen({Key? key, this.userId}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _income = 0;
  int _expanse = 0;
  List<Map<String, dynamic>> _user = [];

  void _refreshTransactions() async {
    final income = await DbHelper.calculateTransaction('income');
    final expanse = await DbHelper.calculateTransaction('expanse');
    final user = await DbHelper.userLoggedIn(widget.userId);

    setState(() {
      _income = income[0]['total'] ?? 0;
      _expanse = expanse[0]['total'] ?? 0;
      _user = user;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          // alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              color: primaryColor,
              height: MediaQuery.of(context).size.height * .20,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24, left: 32),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                _user[0]['name'],
                                style: const TextStyle(
                                  fontSize: 28,
                                  color: whiteColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 4.0),
                                  child: Text(
                                    'Rp',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Text(
                                  CurrencyFormat.convertToIdr(_income, 0),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: successColor,
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Pemasukkan',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: successColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(right: 4.0),
                                  child: Text(
                                    'Rp',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Text(
                                  CurrencyFormat.convertToIdr(_expanse, 0),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: dangerColor,
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Pengeluaran',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: dangerColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              bottom: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () => {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.incomeScreen,
                                      arguments: <String, int>{
                                        'userId': widget.userId ?? 0,
                                      },
                                    )
                                  },
                                  child: Card(
                                    elevation: 2.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/income.png',
                                            width: 120,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 8.0,
                                            ),
                                            child: Text(
                                              'Tambah Pemasukkan',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.expenseScreen,
                                      arguments: <String, int>{
                                        'userId': widget.userId ?? 0,
                                      },
                                    )
                                  },
                                  child: Card(
                                    elevation: 2.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/outcome.png',
                                            width: 120,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 8.0,
                                            ),
                                            child: Text(
                                              'Tambah Pengeluaran',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () => {
                                    Navigator.pushNamed(
                                        context, Routes.historyScreen)
                                  },
                                  child: Card(
                                    elevation: 2.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/detail.png',
                                            width: 120,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 8.0,
                                            ),
                                            child: Text(
                                              'Detail',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => SettingScreen(
                                          userId: widget.userId,
                                        ),
                                      ),
                                    )
                                  },
                                  child: Card(
                                    elevation: 2.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/setting.png',
                                            width: 120,
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 8.0,
                                            ),
                                            child: Text(
                                              'Pengaturan',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
}
