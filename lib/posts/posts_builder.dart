import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:segundo_parcial/posts/posts_state.dart';
import 'posts_cubit.dart';

class PostsBuilder extends StatelessWidget {
  const PostsBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        if (state is PostsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PostsSuccesful) {
          final posts = state.posts;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
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
                    context.read<PostsCubit>().updateRating(index, rating);
                  },
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
