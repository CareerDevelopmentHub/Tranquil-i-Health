class JoinedGroup {
  String postText;
  String postimgUrl;
  String postid;
  DateTime timestamp;
  String userName;
  String userImg;
  String email;
  String role;
  String category;
  double score;
  int? like;
  int? dislike;
  JoinedGroup({
    required this.postText,
    required this.postimgUrl,
    required this.postid,
    required this.timestamp,
    required this.userName,
    required this.userImg,
    required this.email,
    required this.role,
    required this.category,
    required this.score,
    this.like,
    this.dislike,
  });

  factory JoinedGroup.fromJson(Map<String, dynamic> map) {
    return JoinedGroup(
      postText: map['description'] ?? '',
      postimgUrl: map['postimgUrl'] ?? '',
      timestamp: (map['timestamp']).toDate(),
      userName: map['userName'] ?? '',
      userImg: map['userImg'] ?? '',
      email: map['email'] ?? '',
      score: map['score'] ?? '',
      role: map['role'] ?? '',
      like: map['like'] ?? '',
      dislike: map['dislike'] ?? '',
      category: map['category'] ?? '',
      postid: map['postid'] ?? '',
    );
  }
}
