import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'photo.dart';

class PhotoSearchPage extends StatefulWidget {
  @override
  _PhotoSearchPageState createState() => _PhotoSearchPageState();
}

class _PhotoSearchPageState extends State<PhotoSearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<Photo> _photos = [];
  int _currentPage = 1;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Reached the end of the list, load more photos or take any appropriate action.
    }
  }

  Future<void> _searchPhotos(String query, {int page = 1}) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.unsplash.com/search/photos?query=$query&page=$page'),
        headers: {
          'Authorization':
              'Client-ID EHyPqns2tHN16w77Efd8oQfUH8ALlsQou4AWSaY6mto'
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['results'];

        setState(() {
          _photos = data.map((photoJson) => Photo.fromJson(photoJson)).toList();
        });
      } else {
        print('Failed to load photos. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (error) {
      print('Error loading photos: $error');
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(0.0,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Recherche de photos'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(labelText: 'Rechercher'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search, size: 40),
                  onPressed: () {
                    _currentPage = 1;
                    _searchPhotos(_searchController.text, page: _currentPage);
                    _scrollToTop(); // Scroll to top when searching
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              controller: _scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: _photos.length,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: _photos[index].imageUrl,
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _currentPage > 1
                    ? () {
                        setState(() {
                          _currentPage--;
                        });
                        _searchPhotos(_searchController.text,
                            page: _currentPage);
                        _scrollToTop(); // Scroll to top when clicking "Previous"
                      }
                    : null,
                child: Text('Précédent'),
              ),
              SizedBox(width: 16.0),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  setState(() {
                    _currentPage++;
                  });
                  _searchPhotos(_searchController.text, page: _currentPage);
                  _scrollToTop(); // Scroll to top when clicking "Next"
                },
                child: Text('Suivant'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
