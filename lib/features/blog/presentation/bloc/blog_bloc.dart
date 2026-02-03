import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_blog_posts.dart';
import '../../domain/usecases/get_blog_post_by_id.dart';
import '../../domain/usecases/get_comments.dart';
import '../../domain/usecases/add_comment.dart';
import '../../domain/usecases/like_post.dart';
import '../../domain/usecases/create_blog_post.dart';
import '../../domain/usecases/update_blog_post.dart';
import '../../domain/usecases/delete_blog_post.dart';
import 'blog_event.dart';
import 'blog_state.dart';

@injectable
class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final GetBlogPostsUseCase _getBlogPosts;
  final GetBlogPostByIdUseCase _getBlogPostById;
  final GetCommentsUseCase _getComments;
  final AddCommentUseCase _addComment;
  final LikePostUseCase _likePost;
  final CreateBlogPostUseCase _createPost;
  final UpdateBlogPostUseCase _updatePost;
  final DeleteBlogPostUseCase _deletePost;

  BlogBloc(
    this._getBlogPosts,
    this._getBlogPostById,
    this._getComments,
    this._addComment,
    this._likePost,
    this._createPost,
    this._updatePost,
    this._deletePost,
  ) : super(BlogInitial()) {
    on<FetchBlogPosts>(_onFetchBlogPosts);
    on<FetchBlogPostById>(_onFetchBlogPostById);
    on<LikeBlogPost>(_onLikeBlogPost);
    on<AddBlogComment>(_onAddBlogComment);
    on<FetchComments>(_onFetchComments);
    on<CreateBlogPostEvent>(_onCreateBlogPost);
    on<UpdateBlogPostEvent>(_onUpdateBlogPost);
    on<DeleteBlogPostEvent>(_onDeleteBlogPost);
  }

  Future<void> _onFetchBlogPosts(FetchBlogPosts event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final result = await _getBlogPosts(limit: event.limit, startAfterId: event.startAfterId);
    result.fold(
      (failure) => emit(BlogError(failure.message)),
      (posts) => emit(BlogPostsLoaded(posts: posts, hasMore: posts.length == event.limit)),
    );
  }

  Future<void> _onFetchBlogPostById(FetchBlogPostById event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final postResult = await _getBlogPostById(event.id);
    await postResult.fold(
      (failure) async => emit(BlogError(failure.message)),
      (post) async {
        final commentsResult = await _getComments(event.id);
        commentsResult.fold(
          (failure) => emit(BlogPostLoaded(post: post, comments: const [])), // Load post even if comments fail
          (comments) => emit(BlogPostLoaded(post: post, comments: comments)),
        );
      },
    );
  }

  Future<void> _onLikeBlogPost(LikeBlogPost event, Emitter<BlogState> emit) async {
    final result = await _likePost(event.postId);
    result.fold(
      (failure) => emit(BlogError(failure.message)),
      (_) {
        // Refresh the post details so the UI updates
        add(FetchBlogPostById(event.postId));
      },
    );
  }

  Future<void> _onAddBlogComment(AddBlogComment event, Emitter<BlogState> emit) async {
    final result = await _addComment(event.comment);
    await result.fold(
      (failure) async => emit(BlogError(failure.message)),
      (_) {
        emit(CommentAdded());
        // Refresh the post details (which includes comments)
        add(FetchBlogPostById(event.comment.postId));
      },
    );
  }

  Future<void> _onFetchComments(FetchComments event, Emitter<BlogState> emit) async {
    if (state is BlogPostLoaded) {
      final currentState = state as BlogPostLoaded;
      final result = await _getComments(event.postId);
      result.fold(
        (failure) => emit(BlogError(failure.message)),
        (comments) => emit(BlogPostLoaded(post: currentState.post, comments: comments)),
      );
    }
  }

  Future<void> _onCreateBlogPost(CreateBlogPostEvent event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final result = await _createPost(event.post);
    result.fold(
      (failure) => emit(BlogError(failure.message)),
      (_) {
        emit(const BlogOperationSuccess('Post created successfully'));
        add(const FetchBlogPosts()); // Refresh list
      },
    );
  }

  Future<void> _onUpdateBlogPost(UpdateBlogPostEvent event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final result = await _updatePost(event.post);
    result.fold(
      (failure) => emit(BlogError(failure.message)),
      (_) {
        emit(const BlogOperationSuccess('Post updated successfully'));
        add(const FetchBlogPosts()); // Refresh list
      },
    );
  }

  Future<void> _onDeleteBlogPost(DeleteBlogPostEvent event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    final result = await _deletePost(event.id);
    result.fold(
      (failure) => emit(BlogError(failure.message)),
      (_) {
        emit(const BlogOperationSuccess('Post deleted successfully'));
        add(const FetchBlogPosts()); // Refresh list
      },
    );
  }
}
