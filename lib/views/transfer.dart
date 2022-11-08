import 'package:flutter/material.dart';
import 'package:test/controller/index.dart';
import 'package:test/views/convert.dart';
import 'package:test/views/deposit.dart';
import 'package:test/views/widget/tabbar.dart';
import 'package:test/views/withdraw.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({Key? key}) : super(key: key);

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> tabMenus = ['convert', 'withdraw', 'deposit'];
  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        TabBarWidget(
          tabMenus: tabMenus,
          padding: 20,
          tabController: _tabController,
          onpress: () {},
        ),
        Expanded(
            child: TabBarView(
                controller: _tabController,
                children: [ConvertScreen(), WithdrawScreen(), DepositScreen()]))
      ]),
    );
  }
}
