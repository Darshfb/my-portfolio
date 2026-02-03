import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import '../models/blog_post_model.dart';
import '../models/comment_model.dart';

abstract class BlogRemoteDataSource {
  Future<List<BlogPostModel>> getBlogPosts({int limit = 10, String? startAfterId});
  Future<BlogPostModel> getBlogPostById(String id);
  Future<void> createBlogPost(BlogPostModel post);
  Future<void> updateBlogPost(BlogPostModel post);
  Future<void> deleteBlogPost(String id);
  
  Future<List<CommentModel>> getComments(String postId);
  Future<void> addComment(CommentModel comment);
  Future<void> deleteComment(String commentId, String postId);
  
  Future<void> likePost(String postId);
}

@LazySingleton(as: BlogRemoteDataSource)
class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final FirebaseFirestore _firestore;

  BlogRemoteDataSourceImpl(this._firestore);

  @override
  Future<List<BlogPostModel>> getBlogPosts({int limit = 10, String? startAfterId}) async {
    Query query = _firestore
        .collection('blog_posts')
        .orderBy('publishDate', descending: true)
        .limit(limit);

    if (startAfterId != null) {
      final startAfterDoc = await _firestore.collection('blog_posts').doc(startAfterId).get();
      query = query.startAfterDocument(startAfterDoc);
    }

    final querySnapshot = await query.get();
    return querySnapshot.docs.map((doc) => BlogPostModel.fromFirestore(doc)).toList();
  }

  @override
  Future<BlogPostModel> getBlogPostById(String id) async {
    final doc = await _firestore.collection('blog_posts').doc(id).get();
    if (doc.exists) {
      return BlogPostModel.fromFirestore(doc);
    } else {
      throw Exception('Post not found');
    }
  }

  @override
  Future<void> createBlogPost(BlogPostModel post) async {
    await _firestore.collection('blog_posts').add(post.toFirestore());
  }

  @override
  Future<void> updateBlogPost(BlogPostModel post) async {
    await _firestore.collection('blog_posts').doc(post.id).update(post.toFirestore());
  }

  @override
  Future<void> deleteBlogPost(String id) async {
    await _firestore.collection('blog_posts').doc(id).delete();
  }

  @override
  Future<List<CommentModel>> getComments(String postId) async {
    final querySnapshot = await _firestore
        .collection('blog_posts')
        .doc(postId)
        .collection('comments')
        .orderBy('timestamp', descending: true)
        .get();
    return querySnapshot.docs.map((doc) => CommentModel.fromFirestore(doc)).toList();
  }

  @override
  Future<void> addComment(CommentModel comment) async {
    final postRef = _firestore.collection('blog_posts').doc(comment.postId);
    
    await _firestore.runTransaction((transaction) async {
      transaction.set(postRef.collection('comments').doc(), comment.toFirestore());
      transaction.update(postRef, {'commentCount': FieldValue.increment(1)});
    });
  }

  @override
  Future<void> deleteComment(String commentId, String postId) async {
    final postRef = _firestore.collection('blog_posts').doc(postId);
    
    await _firestore.runTransaction((transaction) async {
      transaction.delete(postRef.collection('comments').doc(commentId));
      transaction.update(postRef, {'commentCount': FieldValue.increment(-1)});
    });
  }

  @override
  Future<void> likePost(String postId) async {
    await _firestore.collection('blog_posts').doc(postId).update({
      'likeCount': FieldValue.increment(1),
    });
  }
}
