import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiDataPage extends StatefulWidget {
  @override
  _ApiDataPageState createState() => _ApiDataPageState();
}

class _ApiDataPageState extends State<ApiDataPage> {
  List<Article> _newsArticles = [];

  Future<void> _fetchNewsData() async {
    final apiKey =
        '1a6000526db741de9c8de377cc6072d5'; // Replace with your News API key
    final response = await http.get(
      Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=ma&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'ok') {
        final List<dynamic> articles = data['articles'];
        setState(() {
          _newsArticles =
              articles.map((article) => Article.fromJson(article)).toList();
        });
      } else {
        print('News API error: ${data['message']}');
      }
    } else {
      print('Failed to load news data. Status code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchNewsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('News API Data'),
      ),
      body: _newsArticles.isNotEmpty
          ? ListView.builder(
              itemCount: _newsArticles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_newsArticles[index].title),
                  subtitle: Text(_newsArticles[index].description),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class Article {
  final String title;
  final String description;

  Article({required this.title, required this.description});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      description: json['description'] ?? '',
    );
  }
}
