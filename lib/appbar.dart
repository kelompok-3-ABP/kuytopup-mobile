import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KuyTopUp',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: MyAppBar(),
        body: Container(
            // Your app content here
            ),
      ),
    );
  }
}

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF1B1214),
      title: Row(
        children: [
          Image.asset(
            'assets/page-1/images/whatsappimage2023-05-18at1912-1-7j4.png',
            height: kToolbarHeight * 0.6, // Adjust the size as needed
          ),
          SizedBox(width: 8), // Adjust the spacing as needed
          Text('KuyTopUp'),
        ],
      ),
    );
  }
}
