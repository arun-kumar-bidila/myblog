import 'package:myblog/features/blog/domain/entitites/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.posterId,
    required super.selectedTopics,
    required super.updated,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "content": content,
      "imageUrl": imageUrl,
      "posterId": posterId,
      "selectedTopics": selectedTopics,
      "updated": updated.toIso8601String(),
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map["_id"],
      title: map["title"],
      content: map["content"],
      imageUrl: map["imageUrl"],
      posterId: map["posterId"],
      selectedTopics: List<String>.from(map["selectedTopics"]),
      updated: DateTime.parse(map["updated"]),
    );
  }

  BlogModel copyWith({
    String? id,
    String? title,
    String? content,
    String? imageUrl,
    String? posterId,
    List<String>? selectedTopics,
    DateTime? updated,
  }) {
    return BlogModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      posterId: posterId ?? this.posterId,
      selectedTopics: selectedTopics ?? this.selectedTopics,
      updated: updated ?? this.updated,
    );
  }
}
