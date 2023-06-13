import 'package:flutter/material.dart';
import 'package:myapp/dashboard.dart';
import 'package:myapp/riwayat.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login.dart';

class NavigationDrawerWidget extends StatefulWidget {
  final int user;

  NavigationDrawerWidget({required this.user});
  @override
  _NavigationDrawerWidgetState createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  List userdetail = [];
  bool gede = true;

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('http://192.168.18.67:8000/api/user_${widget.user}'));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);

      setState(() {
        userdetail = decodedData;
        gede = false;
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
    return Drawer(
      child: Container(
        color: Color(0xFF1B1214),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                color: Color.fromARGB(255, 51, 38, 41),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 24,
                    ),
                    Image.asset(
                      'assets/page-1/images/whatsappimage2023-05-18at1912-1-7j4.png',
                      height: 48, // Adjust the size as needed
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      'KuyTopUp',
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    )
                  ],
                )),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: gede
                  ? Text('')
                  : Text(
                      'Hi, ${userdetail[0]["username"].toUpperCase()}',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
            ),
            SizedBox(height: 20),
            buildList(items: items),
            Expanded(child: SizedBox()),
            Container(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MyLogin(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 16, 8, 16),
                        child: Text(
                          'Logout',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Icon(Icons.logout),
                    ],
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 187, 30, 19)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                )),
          ],
        ),
      ),
    );
  }

  Widget buildList({
    required List items,
  }) =>
      ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return buildMenuItems(
            text: item.title,
            onClicked: () => selectItem(context, index),
          );
        },
      );

  void selectItem(BuildContext context, int index) {
    final navigateTo =
        (page) => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => page,
            ));

    switch (index) {
      case 0:
        navigateTo(MyHomePage(user: widget.user));
        break;
      case 1:
        navigateTo(MyHomePage(
          user: widget.user,
        ));
        break;
      case 2:
        navigateTo(MyHomePage(
          user: widget.user,
        ));
        break;
      case 3:
        navigateTo(History(
          user: widget.user,
        ));
        break;
    }
  }

  Widget buildMenuItems({
    required String text,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;

    return Material(
      color: Colors.transparent,
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(color: color, fontSize: 16),
        ),
        onTap: onClicked,
      ),
    );
  }
}

class DrawerItem {
  final String title;

  const DrawerItem({
    required this.title,
  });
}

final items = [
  DrawerItem(title: 'Home'),
  DrawerItem(title: 'About'),
  DrawerItem(title: 'Contact'),
  DrawerItem(title: 'History'),
];
