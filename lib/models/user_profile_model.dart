// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) => UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) => json.encode(data.toJson());

class UserProfileModel {
    final int id;
    final String name;
    final String username;
    final String email;
    final bool isDemo;
    final String photo;
    final String bio;
    final String role;
    final Stats stats;
    final List<Highlight> highlights;
    final List<dynamic> posts;
    final List<Story> stories;
    final List<dynamic> reposts;
    final List<dynamic> mentionedInPosts;
    final DateTime createdAt;
    final DateTime updatedAt;

    UserProfileModel({
        required this.id,
        required this.name,
        required this.username,
        required this.email,
        required this.isDemo,
        required this.photo,
        required this.bio,
        required this.role,
        required this.stats,
        required this.highlights,
        required this.posts,
        required this.stories,
        required this.reposts,
        required this.mentionedInPosts,
        required this.createdAt,
        required this.updatedAt,
    });

    factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        isDemo: json["is_demo"],
        photo: json["photo"],
        bio: json["bio"],
        role: json["role"],
        stats: Stats.fromJson(json["stats"]),
        highlights: List<Highlight>.from(json["highlights"].map((x) => Highlight.fromJson(x))),
        posts: List<dynamic>.from(json["posts"].map((x) => x)),
        stories: List<Story>.from(json["stories"].map((x) => Story.fromJson(x))),
        reposts: List<dynamic>.from(json["reposts"].map((x) => x)),
        mentionedInPosts: List<dynamic>.from(json["mentioned_in_posts"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "is_demo": isDemo,
        "photo": photo,
        "bio": bio,
        "role": role,
        "stats": stats.toJson(),
        "highlights": List<dynamic>.from(highlights.map((x) => x.toJson())),
        "posts": List<dynamic>.from(posts.map((x) => x)),
        "stories": List<dynamic>.from(stories.map((x) => x.toJson())),
        "reposts": List<dynamic>.from(reposts.map((x) => x)),
        "mentioned_in_posts": List<dynamic>.from(mentionedInPosts.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class Highlight {
    final int id;
    final String name;
    final String thumbnailUrl;
    final List<Media> thumbnailMedia;
    final int storiesCount;
    final List<Story> stories;
    final DateTime createdAt;

    Highlight({
        required this.id,
        required this.name,
        required this.thumbnailUrl,
        required this.thumbnailMedia,
        required this.storiesCount,
        required this.stories,
        required this.createdAt,
    });

    factory Highlight.fromJson(Map<String, dynamic> json) => Highlight(
        id: json["id"],
        name: json["name"],
        thumbnailUrl: json["thumbnail_url"],
        thumbnailMedia: List<Media>.from(json["thumbnail_media"].map((x) => Media.fromJson(x))),
        storiesCount: json["stories_count"],
        stories: List<Story>.from(json["stories"].map((x) => Story.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "thumbnail_url": thumbnailUrl,
        "thumbnail_media": List<dynamic>.from(thumbnailMedia.map((x) => x.toJson())),
        "stories_count": storiesCount,
        "stories": List<dynamic>.from(stories.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
    };
}

class Story {
    final int id;
    final List<Media> media;
    final DateTime expiresAt;
    final DateTime createdAt;

    Story({
        required this.id,
        required this.media,
        required this.expiresAt,
        required this.createdAt,
    });

    factory Story.fromJson(Map<String, dynamic> json) => Story(
        id: json["id"],
        media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
        expiresAt: DateTime.parse(json["expires_at"]),
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "media": List<dynamic>.from(media.map((x) => x.toJson())),
        "expires_at": expiresAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
    };
}

class Media {
    final String type;
    final String url;

    Media({
        required this.type,
        required this.url,
    });

    factory Media.fromJson(Map<String, dynamic> json) => Media(
        type: json["type"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "url": url,
    };
}

class Stats {
    final int postsCount;
    final int reelsCount;
    final int storiesCount;
    final int commentsCount;
    final int likesCount;
    final int filesCount;
    final int repostsCount;
    final int mentionedInCount;
    final int followersCount;
    final int followingsCount;

    Stats({
        required this.postsCount,
        required this.reelsCount,
        required this.storiesCount,
        required this.commentsCount,
        required this.likesCount,
        required this.filesCount,
        required this.repostsCount,
        required this.mentionedInCount,
        required this.followersCount,
        required this.followingsCount,
    });

    factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        postsCount: json["posts_count"],
        reelsCount: json["reels_count"],
        storiesCount: json["stories_count"],
        commentsCount: json["comments_count"],
        likesCount: json["likes_count"],
        filesCount: json["files_count"],
        repostsCount: json["reposts_count"],
        mentionedInCount: json["mentioned_in_count"],
        followersCount: json["followers_count"],
        followingsCount: json["followings_count"],
    );

    Map<String, dynamic> toJson() => {
        "posts_count": postsCount,
        "reels_count": reelsCount,
        "stories_count": storiesCount,
        "comments_count": commentsCount,
        "likes_count": likesCount,
        "files_count": filesCount,
        "reposts_count": repostsCount,
        "mentioned_in_count": mentionedInCount,
        "followers_count": followersCount,
        "followings_count": followingsCount,
    };
}
