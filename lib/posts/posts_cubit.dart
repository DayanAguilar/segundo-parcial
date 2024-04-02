import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:segundo_parcial/posts/posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsLoading());

  Future<void> getPosts() async {
    emit(PostsLoading());

    try {
      final response = await Dio().get('https://jsonplaceholder.typicode.com/posts');
      final List<Map<String, dynamic>> posts = List<Map<String, dynamic>>.from(response.data)
          .map((post) => {'post': post, 'rating': 0.0})
          .toList();
      emit(PostsSuccesful(posts: posts, isLoading: false));
    } catch (e) {
      print('Error fetching posts: $e');
      
    }
  }

  void updateRating(int index, double rating) {
    final currentState = state as PostsSuccesful;
    final List<Map<String, dynamic>> updatedPosts = List<Map<String, dynamic>>.from(currentState.posts);
    updatedPosts[index]['rating'] = rating;
    emit(currentState.copyWith(posts: updatedPosts));
    getPostsByRating();
  }

  List<Map<String, dynamic>> getPostsByRating() {
    final currentState = state as PostsSuccesful;
    List<Map<String, dynamic>> filteredPosts = currentState.posts;
    filteredPosts.sort((a, b) => b['rating'].compareTo(a['rating']));
    emit(currentState.copyWith(posts: filteredPosts));
    return filteredPosts;
  }
}