import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/screen/read_news.dart';

import '../secret.dart';

class GetNews extends StatefulWidget {
  String category;
  GetNews({super.key, required this.category});

  @override
  State<GetNews> createState() => _GetNewsState();
}

class _GetNewsState extends State<GetNews> {
  List<dynamic> news = [];

  Future getNews() async {
    final result = await http.get(
      Uri.parse(
        "https://newsapi.org/v2/top-headlines?category=${widget.category}&apiKey=$API_KEY",
      ),
    );

    final data = jsonDecode(result.body);
    if (data['status'] == 'ok')
      setState(() {
        news = data['articles'];
      });
  }

  @override
  void initState() {
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: getNews,
      child: news.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: news.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            WebViewApp(newsUrl: news[index]['url']),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    elevation: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border(
                          left: BorderSide(color: Colors.blue, width: 5),
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                news[index]['urlToImage'] ??
                                    "https://cdn.prod.website-files.com/65e5ae1fb7482afd48d22155/6706e95820aec6a727bf57a2_6706e95603d5848ae30eb147_radio-broadcast-media-transcription-services-1024x576.jpeg",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                news[index]['title'] ?? "No title",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.actor(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
