import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/dashboard.dart';
import 'appbar.dart';
import 'footer.dart';
import 'drawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: MyBerhasil(data: 1),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyBerhasil extends StatefulWidget {
  final int data;

  MyBerhasil({required this.data});

  @override
  _MyBerhasilState createState() => _MyBerhasilState();
}

class _MyBerhasilState extends State<MyBerhasil> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        drawer: NavigationDrawerWidget(user: widget.data),
        appBar: MyAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Text(
                'Pesanan Berhasil',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child:
                            Text('Terima kasih telah berbelanja di KuyTopUp!'),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => MyHomePage(user: widget.data)));
                },
                child: Text('Pesan Lagi',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black)),
              ),
              SizedBox(
                height: 20,
              ),
              FooterWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
