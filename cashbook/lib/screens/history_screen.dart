import 'package:cashbook/styles/constant.dart';
import 'package:cashbook/utilities/currency_format.dart';
import 'package:cashbook/utilities/db_helper.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> _transactions = [];

  void _refreshTransactions() async {
    final data = await DbHelper.fetchTransactions();
    setState(() {
      _transactions = data;
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
                        'Detail',
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
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              radius: 30, // Image radius
                              backgroundColor: lightColor,
                              backgroundImage: _transactions[index]
                                          ['category'] ==
                                      'income'
                                  ? const AssetImage('assets/images/income.png')
                                  : const AssetImage(
                                      'assets/images/salary.png'),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    _transactions[index]['description'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    _transactions[index]['date'],
                                    style: const TextStyle(
                                      color: greyColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                _transactions[index]['category'] == 'income'
                                    ? Icons.add
                                    : Icons.remove,
                                size: 20,
                                color:
                                    _transactions[index]['category'] == 'income'
                                        ? successColor
                                        : dangerColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: Text(
                                  'Rp',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _transactions[index]['category'] ==
                                            'income'
                                        ? successColor
                                        : dangerColor,
                                  ),
                                ),
                              ),
                              Text(
                                CurrencyFormat.convertToIdr(
                                    _transactions[index]['nominal'], 0),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: _transactions[index]['category'] ==
                                          'income'
                                      ? successColor
                                      : dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: _transactions.length,
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: foregroundColor,
                      indent: 12,
                      endIndent: 12,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
