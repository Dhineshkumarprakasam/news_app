import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screen/tabs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        initialIndex: 0,
        length: 7,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            centerTitle: true,
            title: Text(
              "Daily Dose",
              style: GoogleFonts.acme(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            bottom: TabBar(
              tabAlignment: TabAlignment.start,
              labelStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),

              unselectedLabelColor: Color.fromRGBO(176, 190, 197, 1),
              indicatorColor: Colors.blue.shade900,
              isScrollable: true,
              indicatorWeight: 5,

              //business, entertainment, general, health, science, sports, technology
              tabs: [
                Tab(text: "General"),
                Tab(text: "Business"),
                Tab(text: "Health"),
                Tab(text: "Technology"),
                Tab(text: "Science"),
                Tab(text: "Entertainment"),
                Tab(text: "Sports"),
              ],
            ),
          ),

          body: TabBarView(
            children: [
              GetNews(category: "general"),
              GetNews(category: "business"),
              GetNews(category: "health"),
              GetNews(category: "technology"),
              GetNews(category: "science"),
              GetNews(category: "entertainment"),
              GetNews(category: "sports"),
            ],
          ),
        ),
      ),
    );
  }
}
