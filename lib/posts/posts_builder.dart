import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PostsBuilder extends StatefulWidget {
  const PostsBuilder({super.key});

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
                );
              },
            ),
    );
  }
}
