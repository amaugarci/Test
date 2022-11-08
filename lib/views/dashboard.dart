import 'package:flutter/material.dart';
import 'package:test/views/transfer.dart';
import 'package:test/views/currency.dart';
import 'package:test/views/Transaction.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key}) {}

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool changed = false;
  int _selectedIndex = 0;
  String title = "home";
  final _pageController = PageController(initialPage: 0);
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          setState(() {
            title = "Current money";
          });
          break;
        case 1:
          setState(() {
            title = "Transfer";
          });
          break;
        case 2:
          setState(() {
            title = "Transactions";
          });
          break;
      }
    });
    _pageController.animateToPage(index,
        duration: const Duration(microseconds: 300), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Container(),
        title: Text(title),
      ),
      backgroundColor: Colors.white,
      key: scaffoldKey,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [CurrencyScreen(), TransferScreen(), TransactionScreen()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Current money',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.transform),
            label: 'Transfer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Transactions',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
