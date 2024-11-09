// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:appwrite/appwrite.dart';
// import 'package:appwrite/enums.dart';
// import 'package:appwrite/models.dart';
// import 'package:buk_cuk/appwrite_config/appwrite_config.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fpdart/fpdart.dart';
//
//
// final postApiProvider = Provider((ref) {
//   return PostApi(database: ref.watch(appwriteDatabaseProvider), realtime: ref.watch(appwriteRealTimeProvider));
// });
// abstract class PostApiInterface{
// FutureEither<PostModel> post({required PostModel postModel});
// FutureEither<PostModel> updatePost({required PostModel postModel});
// Future<List<Document>> getAllPosts();
// FutureVoid deletePost({required String postId, required BuildContext context});
// FutureEither<Document> likePost({required PostModel post});
// FutureVoid disLikePost({required String postId});
// Stream<RealtimeMessage> getRealtimePosts();
// Future<List<Document>> getPostByUserId({required String userId});
// Future<List<Document>> getAllLikes({required String postId});
//
// }
//
// class PostApi implements PostApiInterface{
//   final Databases _database;
//   final Realtime _realtime;
//   PostApi({required Databases database, required Realtime realtime}): _database=database, _realtime=realtime;
//   @override
//   FutureEither<PostModel> post({required PostModel postModel})async {
//     try {
//       final response = await _database.createDocument(
//         databaseId: databaseId,
//         documentId: postModel.postId,
//         collectionId: collectionIdPosts,
// data: postModel.toMap()
//       );
//       final postResponse= PostModel.fromMap(response.data);
//       return right(postResponse);
//     } on AppwriteException catch (e, st) {
//       return left(Failure(
//           e.message ?? "Something went wrong!", st.toString()));
//     } catch (e, st) {
//       return left(Failure(e.toString(), st.toString()));
//     }
//
//   }
//
//   @override
//   FutureEither<PostModel> updatePost({required PostModel postModel}) async{
//     try {
//       final response = await _database.updateDocument(
//         databaseId: databaseId,
//         collectionId: collectionIdPosts,
//         documentId: postModel.postId,
//         data: postModel.toMap()
//       );
//       final postResponse= PostModel.fromMap(response.data);
//       return right(postResponse);
//     } on AppwriteException catch (e, st) {
//       return left(Failure(
//           e.message ?? "Something went wrong!", st.toString()));
//     } catch (e, st) {
//       return left(Failure(e.toString(), st.toString()));
//     }
//   }
//
//   @override
//   Future<List<Document>> getAllPosts()async {
//       final response = await _database.listDocuments(
//         databaseId: databaseId,
//         collectionId: collectionIdPosts,
//         queries: [
//           Query.orderDesc('createdAt')
//         ]
//       );
//       final posts = response.documents;
//       return posts;
//   }
//
//   @override
//   Stream<RealtimeMessage> getRealtimePosts() {
//     log('Subscribing to realtime posts');
//     return _realtime.subscribe([
//       'databases.$databaseId.collections.$collectionIdPosts.documents.*.*'
//     ]
//     ).stream;
//   }
//
//   @override
//   FutureVoid deletePost({required String postId, required BuildContext context})async {
//     try {
//       await _database.deleteDocument(
//         databaseId: databaseId,
//         collectionId: collectionIdPosts,
//         documentId: postId
//       );
//       UtilMethods().showSnackBar(context, 'Post Deleted Successfully');
//     } catch (e, st) {
//       UtilMethods().showSnackBar(context, 'Something went wrong!');
//     }
//   }
//
//   @override
//   FutureEither<Document> likePost({required PostModel post})async {
//     try {
//       final updatedPost= await _database.updateDocument(databaseId: databaseId, collectionId: collectionIdPosts, documentId: post.postId, data: {
//         'likes':post.likes,
//         'likeCount':post.likeCount,
//       });
//       Constants.logger.w(updatedPost.data['likeCount']);
//       return right(updatedPost);
//     } on AppwriteException catch (e, st) {
//       return left(Failure(
//           e.message ?? "Something went wrong!", st.toString()));
//     } catch (e, st) {
//       return left(Failure(e.toString(), st.toString()));
//     }
//   }
//
//   @override
//   Future<List<Document>> getAllLikes({required String postId})async {
//     final response = await _database.listDocuments(
//       databaseId: databaseId,
//       collectionId: collectionIdLikes,
//         queries: [
//           Query.equal('postId', postId)
//         ]
//     );
// return response.documents;
//   }
//
//   @override
//   Future<List<Document>> getPostByUserId({required String userId}) async{
//     final response = await _database.listDocuments(
//       databaseId: databaseId,
//       collectionId: collectionIdPosts,
//       queries: [
//         Query.equal('userId', userId),
//         Query.orderDesc('createdAt')
//       ]
//     );
//     return response.documents;
//   }
//
//   @override
//   FutureVoid disLikePost({required String postId, })async {
//     try {
//       await _database.deleteDocument(
//         databaseId: databaseId,
//         collectionId: collectionIdLikes,
//         documentId: postId,
//       );
//     } catch (e, st) {
//       Constants.logger.e(e.toString());
//     }
//   }
//
//
// }
