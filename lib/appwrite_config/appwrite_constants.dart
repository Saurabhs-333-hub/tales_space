const String appwriteUrl = 'https://cloud.appwrite.io/v1';
const String projectId = '67162495000ad07eaa7a';
const String databaseId = '6716262a00132eb557c2';
const String appwriteApiKey =
    'standard_1af360c756e31afb3228c0b3252ffc3ba8ab453a377a5017943b19ed8f60c7a75b2f4944b4ce660c9e6797586a8fcd4619159cf314086b39ed5ea94e86c8b3861e51373fcbe8a69a8621cf9577e95048a82fae3c708018b3ec53f8f9f532bcd33c3e809c26e56db621d2ad4fd84f888b4d4829d1092711d6665d355dd3a31c5c';

const String collectionIdUsers = '6716268d003e3334f39c';
const String collectionIdGlimpses = '66907b650030b3dc12ed';
const String collectionIdCategories = '65e45befb1fea1323a5c';
const String collectionIdSubcategories = '65e0f7d30c5c704ca29c';
const String collectionIdSellers = '65e44abc80ce341019cd';
const String collectionIdProducts = '65e44b1f0c5c7084f5f4';
const String collectionIdOrders = '65e44b1f0c5c7084f5f4';
const String collectionIdCarts = '65e44b1f0c5c7084f5f4';
const String collectionIdSubscribers = '6658cc4c00138f22b610';
const String collectionIdUserSettings = '666063110016d339d51c';
const String bucketNameImages = 'images';
const String bucketNameVideos = 'videos';

const String bucketIdImages = '670127f2002b37291aeb';
const String bucketIdVideos = '65e3cb1509c79f706d61';

const String placeholderDeafultImageId = '65be6276d0f1ce53eb4e';
const String placeholderDeafultImageUrl =
    'https://images.unsplash.com/photo-1540324155974-7523202daa3f?q=80&w=1915&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
String imageUrl(String imageId) =>
    '$appwriteUrl/storage/buckets/$bucketIdImages/files/$imageId/view?project=$projectId&mode=admin';
String videoUrl(String videoId) =>
    '$appwriteUrl/storage/buckets/$bucketIdVideos/files/$videoId/view?project=$projectId&mode=admin';
