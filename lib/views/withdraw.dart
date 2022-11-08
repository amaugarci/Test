import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test/controller/index.dart';
import 'package:test/model/cash_model.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  bool isloading = true;
  late List<Cash> cash_list;
  final _con = MainController();
  Future<void> getCurrencyList() async {
    try {
      final mid = await _con.getCashList();
      setState(() {
        cash_list = mid;
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

  String alert = '';
  AddCounselStep2Page() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text("Alert", style: TextStyle(fontSize: 15))),
          content: Text(alert, style: TextStyle(fontSize: 14)),
          buttonPadding: EdgeInsets.all(0),
          actions: <Widget>[
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 1,
                      height: 40,
                    ),
                    new FlatButton(
                      textColor: Color.fromARGB(255, 110, 198, 210),
                      child: new Text('ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Container(
                      width: 1,
                      height: 40,
                    ),
                    new FlatButton(
                      textColor: Color.fromARGB(255, 110, 198, 210),
                      child: new Text('cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Container(
                      width: 1,
                      height: 40,
                    ),
                  ],
                ),
              ],
            )
          ],
        );
      },
    );
  }

  String selectedValue = '';
  final _valueController = TextEditingController(text: '');
  Future<void> withdraw() async {
    try {
      var amount = _valueController.text;
      if (amount == '' || selectedValue == '') {
        setState(() {
          alert = 'PLease enter valid value';
        });
        AddCounselStep2Page();
        return;
      }
      final res =
          await _con.withdraw(int.parse(selectedValue), int.parse(amount));
      setState(() {
        alert = res;
      });
      AddCounselStep2Page();
    } catch (e) {
      print(e.toString());
    }
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
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              DropdownButtonFormField2(
                decoration: InputDecoration(
                  //Add isDense true and zero Padding.
                  //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  //Add more decoration as you want here
                  //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                ),
                isExpanded: true,
                hint: const Text(
                  'Select Your Currency',
                  style: TextStyle(fontSize: 14),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 30,
                buttonHeight: 60,
                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                items: cash_list
                    .map((item) => DropdownMenuItem<String>(
                          value: item.id.toString(),
                          child: Text(
                            item.symbol,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Please select Currency.';
                  }
                },
                onChanged: (value) {
                  selectedValue = value.toString();
                  //Do something when changing the item if you want.
                },
                onSaved: (value) {
                  selectedValue = value.toString();
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _valueController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  hintText: 'Enter Your Full Name.',
                  hintStyle: const TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Theme.of(context).focusColor,
                    borderRadius: BorderRadius.circular(20)),
                child: InkWell(
                  onTap: () {
                    withdraw();
                  },
                  child: const Center(
                    child: Text(
                      'Withdraw',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),
            ]),
          );
  }
}
