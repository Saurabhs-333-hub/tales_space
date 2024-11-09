// Base content model
class Content {
  String? id;
  String? title;
  String? authorId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<String>? tags;
  String? status;
  Map<String, dynamic>? metadata;
  int? viewCount;
  int? likeCount;
  List<String>? likedByUserIds;
  // List<Comment>? comments;

  Content({
    this.id,
    this.title,
    this.authorId,
    this.createdAt,
    this.updatedAt,
    this.tags,
    this.status,
    this.metadata,
    this.viewCount,
    this.likeCount,
    this.likedByUserIds,
    // this.comments,
  });

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    authorId = json['authorId'];
    createdAt =
        json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null;
    updatedAt =
        json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null;
    tags = json['tags']?.cast<String>();
    status = json['status'];
    metadata = json['metadata'];
    viewCount = json['viewCount'];
    likeCount = json['likeCount'];
    likedByUserIds = json['likedByUserIds']?.cast<String>();
    // if (json['comments'] != null) {
    //   comments = <Comment>[];
    //   json['comments'].forEach((v) {
    //     comments!.add(Comment.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['authorId'] = authorId;
    data['createdAt'] = createdAt?.toIso8601String();
    data['updatedAt'] = updatedAt?.toIso8601String();
    data['tags'] = tags;
    data['status'] = status;
    data['metadata'] = metadata;
    data['viewCount'] = viewCount;
    data['likeCount'] = likeCount;
    data['likedByUserIds'] = likedByUserIds;
    // if (comments != null) {
    //   data['comments'] = comments!.map((v) => v.toJson()).toList();
    // }
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Content &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          authorId == other.authorId;

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ authorId.hashCode;

  Content copyWith({
    String? id,
    String? title,
    String? authorId,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? tags,
    String? status,
    Map<String, dynamic>? metadata,
    int? viewCount,
    int? likeCount,
    List<String>? likedByUserIds,
    // List<Comment>? comments,
  }) {
    return Content(
      id: id ?? this.id,
      title: title ?? this.title,
      authorId: authorId ?? this.authorId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tags: tags ?? this.tags,
      status: status ?? this.status,
      metadata: metadata ?? this.metadata,
      viewCount: viewCount ?? this.viewCount,
      likeCount: likeCount ?? this.likeCount,
      likedByUserIds: likedByUserIds ?? this.likedByUserIds,
      // comments: comments ?? this.comments,
    );
  }
}

class ContentSection {
  String? id;
  String? contentId;
  int? orderIndex;
  String? title;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;
  Map<String, dynamic>? metadata;

  ContentSection({
    this.id,
    this.contentId,
    this.orderIndex,
    this.title,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.metadata,
  });

  ContentSection.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contentId = json['contentId'];
    orderIndex = json['orderIndex'];
    title = json['title'];
    content = json['content'];
    createdAt =
        json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null;
    updatedAt =
        json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null;
    metadata = json['metadata'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['contentId'] = contentId;
    data['orderIndex'] = orderIndex;
    data['title'] = title;
    data['content'] = content;
    data['createdAt'] = createdAt?.toIso8601String();
    data['updatedAt'] = updatedAt?.toIso8601String();
    data['metadata'] = metadata;
    return data;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContentSection &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          contentId == other.contentId;

  @override
  int get hashCode => id.hashCode ^ contentId.hashCode;

  ContentSection copyWith({
    String? id,
    String? contentId,
    int? orderIndex,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<String, dynamic>? metadata,
  }) {
    return ContentSection(
      id: id ?? this.id,
      contentId: contentId ?? this.contentId,
      orderIndex: orderIndex ?? this.orderIndex,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      metadata: metadata ?? this.metadata,
    );
  }
}

class Story extends Content {
  String? genre;
  String? summary;
  List<Chapter>? chapters;
  bool? isSerializedStory;
  DateTime? nextChapterReleaseDate;
  String? maturityRating;
  Map<String, dynamic>? storyMetadata;

  Story({
    super.id,
    super.title,
    super.authorId,
    super.createdAt,
    super.updatedAt,
    this.genre,
    this.summary,
    this.chapters,
    this.isSerializedStory,
    this.nextChapterReleaseDate,
    this.maturityRating,
    this.storyMetadata,
    super.tags,
    super.status,
    super.metadata,
    super.viewCount,
    super.likeCount,
    super.likedByUserIds,
    // super.comments,
  });

  Story.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    genre = json['genre'];
    summary = json['summary'];
    if (json['chapters'] != null) {
      chapters = <Chapter>[];
      json['chapters'].forEach((v) {
        chapters!.add(Chapter.fromJson(v));
      });
    }
    isSerializedStory = json['isSerializedStory'];
    nextChapterReleaseDate = json['nextChapterReleaseDate'] != null
        ? DateTime.parse(json['nextChapterReleaseDate'])
        : null;
    maturityRating = json['maturityRating'];
    storyMetadata = json['storyMetadata'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['genre'] = genre;
    data['summary'] = summary;
    if (chapters != null) {
      data['chapters'] = chapters!.map((v) => v.toJson()).toList();
    }
    data['isSerializedStory'] = isSerializedStory;
    data['nextChapterReleaseDate'] = nextChapterReleaseDate?.toIso8601String();
    data['maturityRating'] = maturityRating;
    data['storyMetadata'] = storyMetadata;
    return data;
  }
}

class Chapter extends ContentSection {
  int? chapterNumber;
  String? chapterTitle;
  List<Scene>? scenes;
  int? estimatedReadingTime;
  bool? isPremium;

  Chapter({
    super.id,
    super.contentId,
    super.orderIndex,
    super.title,
    super.content,
    super.createdAt,
    super.updatedAt,
    this.chapterNumber,
    this.chapterTitle,
    this.scenes,
    this.estimatedReadingTime,
    this.isPremium,
    super.metadata,
  });

  Chapter.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    chapterNumber = json['chapterNumber'];
    chapterTitle = json['chapterTitle'];
    if (json['scenes'] != null) {
      scenes = <Scene>[];
      json['scenes'].forEach((v) {
        scenes!.add(Scene.fromJson(v));
      });
    }
    estimatedReadingTime = json['estimatedReadingTime'];
    isPremium = json['isPremium'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['chapterNumber'] = chapterNumber;
    data['chapterTitle'] = chapterTitle;
    if (scenes != null) {
      data['scenes'] = scenes!.map((v) => v.toJson()).toList();
    }
    data['estimatedReadingTime'] = estimatedReadingTime;
    data['isPremium'] = isPremium;
    return data;
  }
}

class Scene extends ContentSection {
  String? sceneDescription;
  List<String>? characters;
  String? location;
  String? timeOfDay;

  Scene({
    super.id,
    super.contentId,
    super.orderIndex,
    super.title,
    super.content,
    super.createdAt,
    super.updatedAt,
    this.sceneDescription,
    this.characters,
    this.location,
    this.timeOfDay,
    super.metadata,
  });

  Scene.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    sceneDescription = json['sceneDescription'];
    characters = json['characters']?.cast<String>();
    location = json['location'];
    timeOfDay = json['timeOfDay'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['sceneDescription'] = sceneDescription;
    data['characters'] = characters;
    data['location'] = location;
    data['timeOfDay'] = timeOfDay;
    return data;
  }
}
