import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CreatePostModel {
  //userimage,username,timestamp,posttext,postimg.
  String? userImg;
  String? userName;
  DateTime? timestamp;
  String? postText;
  String? postimgUrl;
  String? score;
  CreatePostModel({
    this.userImg,
    this.userName,
    this.timestamp,
    this.postText,
    this.postimgUrl,
    this.score,
  });

  CreatePostModel copyWith({
    String? userImg,
    String? userName,
    DateTime? timestamp,
    String? postText,
    String? postimgUrl,
  }) {
    return CreatePostModel(
      userImg: userImg ?? this.userImg,
      userName: userName ?? this.userName,
      timestamp: timestamp ?? this.timestamp,
      postText: postText ?? this.postText,
      postimgUrl: postimgUrl ?? this.postimgUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userImg': userImg,
      'userName': userName,
      'timestamp': timestamp?.millisecondsSinceEpoch,
      'postText': postText,
      'postimgUrl': postimgUrl,
    };
  }

  factory CreatePostModel.fromMap(Map<String, dynamic> map) {
    return CreatePostModel(
      userImg: map['userImg'],
      userName: map['userName'],
      timestamp: map['timestamp'] != null
          ? (map['timestamp'] as Timestamp).toDate()
          : null,
      postText: map['postText'],
      postimgUrl: map['postimgUrl'],
      score: map['score'],
      // (json['timestamp'] as Timestamp).toDate();
    );
  }

  String toJson() => json.encode(toMap());

  factory CreatePostModel.fromJson(String source) =>
      CreatePostModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreatePostModel(userImg: $userImg, userName: $userName, timestamp: $timestamp, postText: $postText, postimgUrl: $postimgUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreatePostModel &&
        other.userImg == userImg &&
        other.userName == userName &&
        other.timestamp == timestamp &&
        other.postText == postText &&
        other.postimgUrl == postimgUrl;
  }

  @override
  int get hashCode {
    return userImg.hashCode ^
        userName.hashCode ^
        timestamp.hashCode ^
        postText.hashCode ^
        postimgUrl.hashCode;
  }
}
