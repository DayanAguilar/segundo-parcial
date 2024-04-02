import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class PostsBuilder extends StatefulWidget {
  const PostsBuilder({Key? key});

  @override
  State<PostsBuilder> createState() => _PostsBuilderState();
}

class _PostsBuilderState extends State<PostsBuilder> {
  List<Map<String, dynamic>> _posts = [];
  bool _isLoaded = false;
  double _minRating = 0;

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  Future<void> getPosts() async {
    setState(() {
      _isLoaded = true;
    });

    try {
      final response =
          await Dio().get('https://jsonplaceholder.typicode.com/posts');
      setState(() {
        _posts = List<Map<String, dynamic>>.from(response.data)
            .map((post) => {'post': post, 'rating': 0.0})
            .toList();
        _isLoaded = false;
      });
    } catch (e) {
      setState(() {
        _isLoaded = false;
      });
      print('Error fetching posts: $e');
    }
  }

  void updateRating(int index, double rating) {
    setState(() {
      _posts[index]['rating'] = rating;
    });
  }

  List<Map<String, dynamic>> getPostsByRating(double minRating) {
    List<Map<String, dynamic>> filteredPosts = _posts;
    filteredPosts.sort((a, b) => b['rating']
        .compareTo(a['rating'])); // Ordena de mayor a menor calificación
    return filteredPosts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: _isLoaded
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: getPostsByRating(_minRating).length,
              itemBuilder: (context, index) {
                final post = getPostsByRating(_minRating)[index];
                return ListTile(
                  title: Text(post['post']['title']),
                  subtitle: Text(post['post']['body']),
                  trailing: RatingBar.builder(
                    initialRating: post['rating'],
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 20,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      updateRating(index, rating);
                    },
                  ),
                );
              },
            ),
    );
  }
}
