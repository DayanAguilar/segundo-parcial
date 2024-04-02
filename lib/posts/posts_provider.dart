import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:segundo_parcial/posts/posts_builder.dart';
import 'package:segundo_parcial/posts/posts_cubit.dart';

class PostsProvider extends StatelessWidget {
  const PostsProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsCubit()..getPosts(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Posts'),
        ),
        body: PostsBuilder(),
      ),
    );
  }
}
