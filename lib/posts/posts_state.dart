class PostsState {
  PostsState();
}
class PostsLoading extends PostsState {
  PostsLoading();
}
class PostsSuccesful extends PostsState{
  final List<Map<String, dynamic>> posts;
  final bool isLoading;

  PostsSuccesful({required this.posts, this.isLoading = false});

  @override
  List<Object?> get props => [posts, isLoading];
   PostsSuccesful copyWith({List<Map<String, dynamic>>? posts, bool? isLoading}) {
    return PostsSuccesful(
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
    );
  }

}