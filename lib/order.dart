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
      home: MyOrder(data: {
        'id': 'ICIGUK',
        'user_id': 1,
      }),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyOrder extends StatefulWidget {
  final Map data;

  MyOrder({required this.data});

  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  List gamesData = [];
  bool coba = true;

  Future<void> deleteResource() async {
    var url = 'http://192.168.18.67:8000/api/delete_${widget.data["id"]}';

    var response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      print('Resource deleted successfully');
    } else {
      print('Failed to delete resource. Error: ${response.statusCode}');
    }
  }

  Future<void> fetchData() async {
    final response = await http.get(
        Uri.parse('http://192.168.18.67:8000/api/bayar_${widget.data["id"]}'));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);

      setState(() {
        gamesData = decodedData;
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
        drawer: NavigationDrawerWidget(user: widget.data['user_id']),
        appBar: MyAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Text(
                'Detail Pesanan',
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
                        child: Text('Product:'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Item:',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Price:'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('User ID:'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('Payment:'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(''),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: coba
                            ? Text('')
                            : Text(gamesData[0]['game'][0]['name']),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: coba
                            ? Text('')
                            : Text(gamesData[0]['product'][0]['type']),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: coba
                            ? Text('')
                            : Text("Rp${gamesData[0]['product'][0]['price']}"),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: coba
                            ? Text('')
                            : Text(gamesData[0]['order'][0]['in_game_uid']
                                .toString()),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('DANA - 081314692272'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('BCA - 317200012'),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 40),
              Text(
                '*Harga belum termasuk biaya admin\n**Cek kembali data akun Anda, salah data bukan tanggung jawab kami',
                style: TextStyle(fontSize: 8, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) =>
                              MyBerhasil(data: widget.data['user_id'])));
                    },
                    child: Text('Order',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => EditPage(
                                user: widget.data['user_id'],
                                game: gamesData[0]['game'][0],
                                order: gamesData[0]['order_id'],
                              )));
                    },
                    child: Text('Edit',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.yellow),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black)),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Delete Order'),
                        content: Text('Are you sure?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Yes'),
                            onPressed: () {
                              deleteResource();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MyHomePage(user: widget.data['user_id']),
                                ),
                              );
                            },
                          ),
                          TextButton(
                            child: Text('No'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Cancel',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
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
