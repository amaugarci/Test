import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test/controller/auth_controller.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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

  final _emailController = TextEditingController(text: "test@gmail.com");
  final _passwordController = TextEditingController(text: "123123123");
  final _conpasswordController = TextEditingController(text: "123123123");
  final _nameController = TextEditingController(text: "Ares");
  final _con = AuthController();
  Future<void> register(BuildContext context) async {
    try {
      var name = _nameController.text;
      var email = _emailController.text.trim();
      var password = _passwordController.text;
      var res = await _con.registerEmail(name, email, password);
      if (res == null) {
        setState(() {
          alert = 'net error';
        });
        AddCounselStep2Page();
      } else if (res.statusCode == 201) {
        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
      } else {
        setState(() {
          alert = json.decode(res.body)['message'][0].toString();
        });
        AddCounselStep2Page();
        // AlertDialog(content: Text(json.decode(res.body)['message'][0]));
        // print(json.decode(res.body)['message']);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(),
        title: const Text("Registration Page"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 60.0),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    fillColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).focusColor, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 1),
                    ),
                    hintStyle: const TextStyle(color: Colors.black),
                    labelStyle: const TextStyle(color: Colors.black),
                    labelText: 'name',
                    hintText: 'Enter name'),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
              ),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    fillColor: Colors.black,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).focusColor, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 1),
                    ),
                    hintStyle: const TextStyle(color: Colors.black),
                    labelStyle: const TextStyle(color: Colors.black),
                    labelText: 'Email',
                    hintText: 'Enter email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).focusColor, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 1),
                    ),
                    hintStyle: const TextStyle(color: Colors.black),
                    labelStyle: const TextStyle(color: Colors.black),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: _conpasswordController,
                obscureText: true,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).focusColor, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 1),
                    ),
                    hintStyle: const TextStyle(color: Colors.black),
                    labelStyle: const TextStyle(color: Colors.black),
                    labelText: 'confirm Password',
                    hintText: 'Enter confirm password'),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // InkWell(
            //   onTap: () {
            //     //TODO FORGOT PASSWORD SCREEN GOES HERE
            //   },
            //   child: const Text(
            //     'Forgot Password',
            //     style: TextStyle(color: Colors.blue, fontSize: 15),
            //   ),
            // ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Theme.of(context).focusColor,
                  borderRadius: BorderRadius.circular(20)),
              child: InkWell(
                onTap: () {
                  register(context);
                },
                child: const Center(
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already register?',
                  style: TextStyle(fontSize: 12),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/login", (route) => false);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.blue, fontSize: 12),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
