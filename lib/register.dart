import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'drawer.dart';
import 'login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: MyRegister(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyRegister extends StatefulWidget {
  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  var _formKey = GlobalKey<FormState>();
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();
  var _nameController = TextEditingController();
  var _phoneController = TextEditingController();

  Future<void> registerUser(
      String username, String password, String name, String phone) async {
    final apiUrl =
        'http://192.168.18.67:8000/api/register'; // Replace with your API endpoint

    final response = await http.post(Uri.parse(apiUrl), body: {
      'username': username,
      'password': password,
      'name': name,
      'phone': phone,
    });

    if (response.statusCode == 200) {
      // Registration successful, handle the response here
      final data = jsonDecode(response.body);
      final token = data['token'];
      // Save the token or perform any necessary operations
      print('Registration successful');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => MyLogin(),
        ),
      );
    } else {
      // Registration failed, handle the error here
      print('Registration failed: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        // drawer: NavigationDrawerWidget(),
        // appBar: MyAppBar(),
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Image.asset(
                    'assets/page-1/images/whatsappimage2023-05-18at1912-1-7j4.png',
                    height: 100, // Adjust the size as needed
                  ),
                ),
              ),
              Text(
                "KuyTopUp",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                      child: Text(
                        'CREATE ACCOUNT',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ))),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 0, 30),
                            child: Text(
                              'Username',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            )),
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 0, 0, 30),
                          child: SizedBox(
                            height: 30,
                            width: MediaQuery.of(context).size.width *
                                0.6, // Set the desired height
                            child: TextFormField(
                              controller: _usernameController,
                              validator: (value) {
                                if (value == '') {
                                  return 'Username is required';
                                }
                                return null;
                              },
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                              decoration: InputDecoration(
                                // hintText: 'Search Your Games...',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        12), // Set the placeholder text color
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 0, 30),
                            child: Text(
                              'Password',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            )),
                        Padding(
                          padding: EdgeInsets.fromLTRB(32, 0, 0, 30),
                          child: SizedBox(
                            height: 30,
                            width: MediaQuery.of(context).size.width *
                                0.6, // Set the desired height
                            child: TextFormField(
                              controller: _passwordController,
                              validator: (value) {
                                if (value == '') {
                                  return 'Please enter a password';
                                }
                                return null;
                              },
                              obscureText: true,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                              decoration: InputDecoration(
                                // hintText: 'Search Your Games...',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        12), // Set the placeholder text color
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 0, 30),
                            child: Text(
                              'Nama',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            )),
                        Padding(
                          padding: EdgeInsets.fromLTRB(51.5, 0, 0, 30),
                          child: SizedBox(
                            height: 30,
                            width: MediaQuery.of(context).size.width *
                                0.6, // Set the desired height
                            child: TextFormField(
                              controller: _nameController,
                              validator: (value) {
                                if (value == '') {
                                  return 'Please enter a name';
                                }
                                return null;
                              },
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                              decoration: InputDecoration(
                                // hintText: 'Search Your Games...',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        12), // Set the placeholder text color
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 0, 30),
                            child: Text(
                              'No HP',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            )),
                        Padding(
                          padding: EdgeInsets.fromLTRB(48, 0, 0, 30),
                          child: SizedBox(
                            height: 30,
                            width: MediaQuery.of(context).size.width *
                                0.6, // Set the desired height
                            child: TextFormField(
                              controller: _phoneController,
                              validator: (value) {
                                if (value == '') {
                                  return 'Please enter a phone';
                                }
                                return null;
                              },
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                              decoration: InputDecoration(
                                // hintText: 'Search Your Games...',
                                hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize:
                                        12), // Set the placeholder text color
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState != null &&
                                    _formKey.currentState!.validate()) {
                                  final username = _usernameController.text;
                                  final password = _passwordController.text;
                                  final name = _nameController.text;
                                  final phone = _phoneController.text;
                                  registerUser(username, password, name, phone);
                                }
                              },
                              child: Text('Register',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.black)),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                      builder: (context) => MyLogin())),
                              child: Text('Login',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 58, 46, 48)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white)),
                            ),
                          ],
                        )),
                  ],
                ),
              )
              // FooterWidget(),
            ],
          ),
        )),
      ),
    );
  }
}
