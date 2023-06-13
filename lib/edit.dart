import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/order.dart';
import 'appbar.dart';
import 'footer.dart';
import 'drawer.dart';

class EditPage extends StatefulWidget {
  final Map game;
  final int user;
  final String order;

  EditPage({required this.game, required this.user, required this.order});

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  int selectedIndex = -1;
  int productID = -1;

  List productsData = [];
  String inputValue = '';

  Future<void> postDataToAPI() async {
    final url = 'http://192.168.18.67:8000/api/edit_${widget.order}';

    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final data = <String, dynamic>{
      'product': productID,
      'uid': inputValue,
      'user': widget.user,
    };

    final response = await http.put(Uri.parse(url),
        headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      print('Data edited successfully');
      final data = json.decode(response.body);
      print(data);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => MyOrder(data: data),
        ),
      );
    } else {
      print('Failed to store data. Error: ${response.statusCode}');
    }
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'http://192.168.18.67:8000/api/product_${widget.game["id"]}'));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);

      setState(() {
        productsData = decodedData;
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.all(16), // Add vertical spacing
                  child: Text(
                    widget.game['name'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              Padding(
                padding: EdgeInsets.all(16), // Add vertical spacing
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.transparent,
                        width: 0,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                widget.game['image_url'],
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(16, 16, 0, 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Tutorial Top Up ${widget.game['name']}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10),
                                  Text(
                                    '1. Masukkan ID\n2. Pilih Nominal\n3. Pilih Metode Pembayaran\n4. Klik Order dan Lakukan Pembayaran',
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    )),
              ),
              Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 16, 16, 10),
                          child: Text('User ID',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      SizedBox(
                        height: 30, // Set the desired height
                        child: TextField(
                          style: TextStyle(color: Colors.black, fontSize: 12),
                          onChanged: (value) {
                            // Implement search functionality here
                            setState(() {
                              inputValue = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Masukkan User ID',
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 12), // Set the placeholder text color
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding:
                    EdgeInsets.all(16.0), // Add padding around the search bar
                child: Text(
                  'Pilih Nominal',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    mainAxisExtent: 120,
                  ),
                  itemCount: productsData.length,
                  itemBuilder: (context, index) {
                    final isSelected = index == selectedIndex;
                    final item = productsData[index];
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            productID = productsData[index]['id'];
                          });
                        },
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: isSelected
                                    ? Colors.green
                                    : Color(0xFF1B1214)),
                            child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          productsData[index]['type'],
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Rp${productsData[index]['price']}',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )));
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  postDataToAPI();
                },
                child: Text('Order',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black)),
              ),
              SizedBox(height: 20),
              FooterWidget(),
            ],
          ),
        ),
      ),
    );
  }

  void _processInput(String input) {
    print('Input value: $input');
  }
}
