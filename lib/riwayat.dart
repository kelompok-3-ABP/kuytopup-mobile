import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/edit.dart';
import 'appbar.dart';
import 'footer.dart';
import 'drawer.dart';
import 'berhasil.dart';
import 'dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: History(user: 1),
      debugShowCheckedModeBanner: false,
    );
  }
}

class History extends StatefulWidget {
  final int user;

  History({required this.user});

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List orderData = [];
  bool coba = true;

  Future<void> deleteResource(int index) async {
    var url = 'http://192.168.18.67:8000/api/delete_${orderData[index]["id"]}';

    var response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      print('Resource deleted successfully');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => History(user: widget.user),
        ),
      );
    } else {
      print('Failed to delete resource. Error: ${response.statusCode}');
    }
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('http://192.168.18.67:8000/api/history_${widget.user}'));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);

      setState(() {
        orderData = decodedData;
        coba = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        drawer: NavigationDrawerWidget(user: widget.user),
        appBar: MyAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Text(
                'Riwayat Transaksi',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(16),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: orderData.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Color(0xFF1B1214)),
                            child: SingleChildScrollView(
                                physics: NeverScrollableScrollPhysics(),
                                child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "${orderData[index]['game'][0]['name']}\n${orderData[index]['product'][0]['type']}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              Text(
                                                  "Rp${orderData[index]['product'][0]['price']}\n${orderData[index]['updated_at'].substring(0, 10)}",
                                                  style:
                                                      TextStyle(fontSize: 12)),
                                            ]),
                                        ElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text('Delete History'),
                                                  content:
                                                      Text('Are you sure?'),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      child: Text('Yes'),
                                                      onPressed: () {
                                                        deleteResource(index);
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text('No'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            'Delete',
                                          ),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.white),
                                              foregroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.black)),
                                        ),
                                      ],
                                    )))),
                        SizedBox(height: 10)
                      ],
                    );
                  },
                ),
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
