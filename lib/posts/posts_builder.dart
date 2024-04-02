import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // Importa el paquete de rating bar

class PostsBuilder extends StatefulWidget {
  const PostsBuilder({Key? key});

  @override
  State<PostsBuilder> createState() => _PostsBuilderState();
}

class _PostsBuilderState extends State<PostsBuilder> {
  List<dynamic> _posts = [];
  bool _isLoaded = false;

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
        _posts = List.from(response.data);
        _isLoaded = false;
      });
    } catch (e) {
      setState(() {
        _isLoaded = false;
      });
      print('Error fetching posts: $e');
    }
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
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];
                return ListTile(
                  title: Text(post['title']),
                  subtitle: Text(post['body']),
                  trailing: RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemSize: 20,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    onRatingUpdate: (rating) {
                      // Aquí puedes manejar la calificación del post
                      print('Calificación del post ${post['id']}: $rating');
                    },
                  ),
                );
              },
            ),
    );
  }
}
