import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'appbar.dart';
import 'footer.dart';
import 'drawer.dart';
import 'product.dart';

void main() {
  runApp(MyApp());
}

class MyHomePage extends StatefulWidget {
  final int user;

  MyHomePage({required this.user});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List gamesData = [];
  List<String> imagePaths = [
    'assets/page-1/images/apex1.png',
    'assets/page-1/images/apex1-mCS.png',
    'assets/page-1/images/apex1-v8n.png',
    'assets/page-1/images/apex1-DSe.png',
    'assets/page-1/images/apex1-fGz.png',
    'assets/page-1/images/ml1.png',
    'assets/page-1/images/valo1.png',
    'assets/page-1/images/apex1-yxA.png',
  ];

  List filteredGamesData = [];

  void filterGames(String query) {
    setState(() {
      filteredGamesData = gamesData
          .where((game) => game['name']
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://192.168.18.67:8000/api'));

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);

      // Add image paths to each game object
      for (int i = 0; i < decodedData.length; i++) {
        decodedData[i]['image'] = imagePaths[i % imagePaths.length];
      }

      setState(() {
        gamesData = decodedData;
        filteredGamesData = gamesData;
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
        drawer: NavigationDrawerWidget(
          user: widget.user,
        ),
        appBar: MyAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16), // Add vertical spacing
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/page-1/images/rectangle-3.png',
                      width: 367,
                      height: 108,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.all(16.0), // Add padding around the search bar
                child: SizedBox(
                  height: 30, // Set the desired height
                  child: TextField(
                    style: TextStyle(color: Colors.black, fontSize: 12),
                    onChanged: (value) {
                      // Implement search functionality here
                      filterGames(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search Your Games...',
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
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    mainAxisExtent: 120,
                  ),
                  itemCount: filteredGamesData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProductPage(
                                      game: filteredGamesData[index],
                                      user: widget.user,
                                    ))),
                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.transparent),
                            child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.asset(
                                      filteredGamesData[index]['image'],
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          filteredGamesData[index]['name'],
                                          style: TextStyle(fontSize: 10),
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
              SizedBox(height: 20),
              FooterWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
