// import 'dart:developer';
// import 'dart:io';
//
// import 'package:appwrite/appwrite.dart';
// import 'package:appwrite/models.dart' as model;
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// final postControllerProvider = StateNotifierProvider<PostController,bool>((ref) {
//   return PostController(ref: ref, postApi: ref.watch(postApiProvider), storageApi: ref.watch(storageApiProvider));
// });
// final postProvider = FutureProvider<List<PostModel>>((ref){
//   final postController = ref.watch(postControllerProvider.notifier);
//   return postController.getAllPosts();
// });
//
// final userPostProvider = FutureProvider.family.autoDispose<List<PostModel>, String>((ref,id){
//   final postController = ref.watch(postControllerProvider.notifier);
//   return postController.getPostByUserId(id);
// });
//
// final postsAsSetProvider = FutureProvider.autoDispose<Set<PostModel>>((ref) async {
//   final postController = ref.watch(postControllerProvider.notifier);
//   return await postController.getAllPostsAsSet();
// });
//
// final realTimePostsAsSetProvider = StreamProvider.autoDispose((ref){
//   final postController = ref.watch(postControllerProvider.notifier);
//   return postController.getRealTimePostsAsSet();
// });
//
// final likeProvider = FutureProvider.family((ref,String id){
//   final postController = ref.watch(postControllerProvider.notifier);
//   return postController.getAllLikes(id);
// });
//
// final likeAsSetProvider = FutureProvider.family.autoDispose<Set<LikeModel>,String>((ref,id) async {
//   final postController = ref.watch(postControllerProvider.notifier);
//   return await postController.getAllLikesAsSet(id);
// });
//
// final realTimeLikesAsSetProvider = StreamProvider.family.autoDispose((ref,String id){
//   final postController = ref.watch(postControllerProvider.notifier);
//   return postController.getRealtimeLikesAsSet(id);
// });
// final imagesProvider = StateProvider<List<File>>((ref) => []);
// final postSetProvider = StateProvider<Set<PostModel>>((ref) => {});
// final likesSetProvider = StateProvider<Set<LikeModel>>((ref) => {});
// final countProvider = StateProvider<int>((ref) => 0);
// final isLikedProvider = StateProvider<String>((ref) => '');
// class PostController extends StateNotifier<bool>{
//   final PostApi _postApi;
//   final StorageApi _storageApi;
//   final Ref _ref;
//   PostController({required Ref ref,required PostApi postApi, required StorageApi storageApi}):_ref=ref, _postApi=postApi, _storageApi=storageApi, super(false);
//
//   List<File> images =[];
//
//   void setImages(List<File> value) {
//     _ref.read(imagesProvider).clear();
//     _ref.read(imagesProvider.notifier).state = value;
//     images=value;
//   }
//   void setCount(int value) {
//     _ref.read(countProvider.notifier).state = value;
//   }
//
//   void setLiked(String value) {
//     _ref.read(isLikedProvider.notifier).state = value;
//   }
//   Future<void> post({required BuildContext context,String? caption, List<File>? images}) async {
//
//     if (images!.isNotEmpty) {
//       _shareImageMemories(
//           images: images, caption: caption??'', context: context);
//     } else {
//       if (caption!.isEmpty) {
//         state = true;
//         UtilMethods().showSnackBar(context, 'Please Enter Some Text');
//         state=false;
//         return;
//       }
//       _shareTextMemories(caption: caption, context: context);
//     }
//
//   }
//
//   void _shareTextMemories({required String caption, required BuildContext context}) async {
//     state=true;
//     final postModel = PostModel(
//         caption: caption,
//         userId: _ref.watch(currentUserAccountProvider).value!.$id,
//       postId: ID.unique(),
//       postType: PostType.text.toString(),
//       createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
//       updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
//       imageUrls: [],
//       alt: '',
//       category: '',
//       likes: [],
//       commentCount: 0,
//       likeCount: 0,
//       saveCount: 0,
//       shareCount: 0,
//     );
//     final res = await _postApi.post(postModel: postModel);
//     state = false;
//     res.fold(
//           (l) => UtilMethods().showSnackBar(context, l.message),
//           (r) => UtilMethods().showSnackBar(context, 'Posted Successfully'),
//     );
//
//   }
//
//   void _shareImageMemories({required List<File> images,  String? caption, required BuildContext context}) async {
//     state=true;
//     final imageLinks = await _storageApi.uploadImage(images);
//     final postModel = PostModel(
//         caption: caption,
//         userId: _ref.watch(currentUserAccountProvider).value!.$id,
//         postId: ID.unique(),
//         postType: PostType.image.toString(),
//         createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
//         updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
//         imageUrls: imageLinks,
//         alt: '',
//         category: '',
//       likes: [],
//       commentCount: 0,
//       likeCount: 0,
//       saveCount: 0,
//       shareCount: 0,
//     );
//     final res = await _postApi.post(postModel: postModel);
//     state = false;
//     res.fold(
//           (l) => UtilMethods().showSnackBar(context, l.message),
//           (r) => UtilMethods().showSnackBar(context, 'Posted Successfully'),
//     );
//   }
//
//   void updatePost({required PostModel postModel}) async {
//     state = true;
//     final res = await _postApi.updatePost(postModel: postModel);
//     state = false;
//     res.fold(
//           (l) => Constants.logger.e(l.message),
//           (r) => Constants.logger.i(r.postType),
//     );
//   }
//
//   Set<PostModel> posts = {};
// getAllPostsAsSet()async{
//   List<model.Document> res = await _postApi.getAllPosts();
//   posts = res.map((e) => PostModel.fromMap(e.data)).toSet();
//   // Constants.logger.i(posts);
//   _ref.read(postSetProvider.notifier).state = posts;
//   return posts;
// }
//
// getRealTimePostsAsSet(){
//   RealtimeSubscription? subscription ;
//   Realtime realtime= _ref.read(appwriteRealTimeProvider);
//   log('Subscribing to realtime posts');
//   subscription = realtime.subscribe(['databases.$databaseId.collections.$collectionIdPosts.documents', 'databases.$databaseId.collections.$collectionIdLikes.documents']);
//   subscription.stream.listen((event) {
//     // Constants.logger.i(event);
// getAllPostsAsSet();
//   });
// }
//
//   Future<List<PostModel>> getPostsByCategory(String category) async {
//     final res = await _postApi.getAllPosts();
//     return res.map((e) => PostModel.fromMap(e.data)).where((element) => element.category == category).toList();
// }
//
// Future<List<PostModel>> getPostByUserId(String userId) async {
//     final res = await _postApi.getPostByUserId(userId: userId);
//     return res.map((e) => PostModel.fromMap(e.data)).where((element) => element.userId == userId).toList();
// }
//   Future<List<PostModel>>getAllPosts() async {
//     final res = await _postApi.getAllPosts();
//     return res.map((e) => PostModel.fromMap(e.data)).toList();
//   }
//
//   void deletePost(String postId, BuildContext context) async {
//     state = true;
//      await _postApi.deletePost(postId: postId, context:context);
//     state = false;
//   }
//
//   void likePost(PostModel post, UserModel user) async {
//     // state = true;
//     final likeId = ID.unique();
//     List<dynamic> likes = post.likes;
//     if (post.likes.contains(user.userid)) {
//       likes.remove(user.userid);
//     } else {
//       likes.add(user.userid);
//     }
//     post=post.copyWith(likes: likes, likeCount: likes.length);
//     final res = await _postApi.likePost(post: post);
//     // state = false;
//
//     res.fold(
//           (l) => Constants.logger.e(l.message),
//           (r) => Constants.logger.i(r.data),
//     );
//   }
//   Set<LikeModel> likes ={};
//    getAllLikesAsSet(String postId) async {
//     List<model.Document> res = await _postApi.getAllLikes(postId: postId);
//     likes = res.map((e) => LikeModel.fromMap(e.data)).toSet();
//     _ref.read(likesSetProvider.notifier).state = likes;
//     Constants.logger.i(likes);
//     return likes;
//   }
//
//   getRealtimeLikesAsSet(String postId){
//     RealtimeSubscription? subscription ;
//     Realtime realtime= _ref.read(appwriteRealTimeProvider);
//     log('Subscribing to realtime likes');
//     subscription = realtime.subscribe(['databases.$databaseId.collections.$collectionIdLikes.documents']);
//     subscription.stream.listen((event) {
//       Constants.logger.e(event.events);
//       getAllLikesAsSet(postId);
//     });
//   }
//
//   Future<List<LikeModel>?> getAllLikes(String postId) async {
//     try{
//     final res = await _postApi.getAllLikes(postId: postId);
//     Constants.logger.i(res);
//     return res.map((e) => LikeModel.fromMap(e.data)).toList();
//     }catch(e){
//       Constants.logger.e(e);
//       return null;
//     }
//   }
//
//   void disLikePost(String postId) async {
//     state = true;
//     final res = await _postApi.disLikePost(postId: postId);
//     state = false;
//   }
//
//
// }
