import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'drawer.dart';
import 'dashboard.dart';
import 'register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: MyLogin(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    bool _isLoading = false;

    BuildContext _getContext() {
      // Return the context where you want to use it, such as a parent widget's context
      return context;
    }

    Future<void> _login() async {
      setState(() {
        _isLoading = true;
      });

      final String username = _usernameController.text;
      final String password = _passwordController.text;

      // Make a POST request to your login endpoint
      final response = await http.post(
        Uri.parse('http://192.168.18.67:8000/api/login'),
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Login successful
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String token = responseData['token'];

        // Store the token in shared preferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);

        // Navigate to the home screen or any other screen after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                MyHomePage(user: responseData['user']['id']),
          ),
        );
      } else {
        // Login failed
        showDialog(
          context: _getContext(),
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Failed'),
              content: Text('Please check your username and password.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }

      setState(() {
        _isLoading = false;
      });
    }

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
                            'SIGN IN',
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
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                )),
                            Padding(
                              padding: EdgeInsets.fromLTRB(30, 0, 0, 30),
                              child: SizedBox(
                                height: 30,
                                width: MediaQuery.of(context).size.width *
                                    0.6, // Set the desired height
                                child: TextFormField(
                                  // autofocus: true,
                                  controller: _usernameController,
                                  validator: (value) {
                                    if (value == '') {
                                      return 'Username is required';
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
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
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                )),
                            Padding(
                              padding: EdgeInsets.fromLTRB(32, 0, 0, 30),
                              child: SizedBox(
                                height: 30,
                                width: MediaQuery.of(context).size.width *
                                    0.6, // Set the desired height
                                child: TextFormField(
                                  // autofocus: true,
                                  obscureText: true,
                                  obscuringCharacter: 'Æ',
                                  controller: _passwordController,
                                  validator: (value) {
                                    if (value == '') {
                                      return 'Password is required';
                                    }
                                    return null;
                                  },
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12),
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
                            child: _isLoading
                                ? CircularProgressIndicator()
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState != null &&
                                              _formKey.currentState!
                                                  .validate()) {
                                            _login();
                                          }
                                        },
                                        child: Text('Login',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.black)),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ElevatedButton(
                                        onPressed: () => Navigator.of(context)
                                            .pushReplacement(MaterialPageRoute(
                                                builder: (context) =>
                                                    MyRegister())),
                                        child: Text('Register',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .all<Color>(Color.fromARGB(
                                                        255, 58, 46, 48)),
                                            foregroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white)),
                                      ),
                                    ],
                                  )),
                      ],
                    ),
                  )
                  // FooterWidget(),
                ],
              )),
        ),
      ),
    );
  }
}
