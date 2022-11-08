import 'package:flutter/material.dart';
import 'package:test/controller/index.dart';
import 'package:test/model/Transaction_model.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);
  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  bool isloading = true;
  late List<Transaction> transaction_list;
  final _con = MainController();
  Future<void> getCurrencyList() async {
    try {
      final mid = await _con.getTransactionList();
      setState(() {
        transaction_list = mid;
        isloading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    getCurrencyList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Container(
            child: Container(
            height: MediaQuery.of(context).size.width,
            color: Colors.transparent,
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          ))
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: DataTable(
              border: TableBorder(
                  bottom: BorderSide(
                      color: Colors.black.withOpacity(0.3), width: 1)),
              dataRowHeight: 38,
              headingRowHeight: 50,
              horizontalMargin: 0,
              showBottomBorder: true,
              showCheckboxColumn: false,
              columnSpacing: 0,
              columns: [
                DataColumn(
                    label: Text('Curreny',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700))),
                DataColumn(
                    label: Text('Amount',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700))),
                DataColumn(
                    label: Text('Descripton',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700))),
              ],
              rows: [
                for (int i = 0; i < transaction_list.length; i++)
                  DataRow(cells: [
                    DataCell(
                      Text(transaction_list[i].symbol.toString(),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700)),
                    ),
                    DataCell(Text(transaction_list[i].amount.toString(),
                        style: TextStyle(
                            color: transaction_list[i].amount < 0
                                ? Colors.red
                                : Colors.blue,
                            fontSize: 14,
                            fontWeight: FontWeight.w400))),
                    DataCell(Text(transaction_list[i].description.toString(),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400))),
                  ]),
              ],
            ),
          );
  }
}
