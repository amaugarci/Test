import 'package:flutter/material.dart';
import 'package:test/controller/index.dart';
import 'package:test/model/currency_model.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({Key? key}) : super(key: key);

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  bool isloading = true;
  late List<Cuurrency> currency_list;
  final _con = MainController();
  Future<void> getCurrencyList() async {
    try {
      final mid = await _con.getCurrencyList();
      setState(() {
        currency_list = mid;
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
                    label: Text('Name',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700))),
                DataColumn(
                    label: Text('Amount',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700))),
              ],
              rows: [
                for (int i = 0; i < currency_list.length; i++)
                  DataRow(cells: [
                    DataCell(
                      Text(currency_list[i].currency_name.toString(),
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700)),
                    ),
                    DataCell(Text(currency_list[i].sum.toString(),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400))),
                  ]),
              ],
            ),
          );
  }
}
