class SearchPhotoListResponse {
  final List<SearchPhotoList> results;

  SearchPhotoListResponse(this.results);

  SearchPhotoListResponse.fromJsonArray(List json)
      : results = json.map((i) => new SearchPhotoList.fromJson(i)).toList();
}

class SearchPhotoList {
  int total;
  int totalPages;
  Results results;

  SearchPhotoList({this.total, this.totalPages, this.results});

  SearchPhotoList.fromJson(Map<String, dynamic> json) {
    this.total = json['total'];
    this.totalPages = json['total_pages'];
    this.results = json['results'];
  }
}

class Results {
  String id;
  String createdAt;
  int width;
  int height;
  String color;
  int likes;
  bool likedByUser;
  String description;
  User user;
  Urls urls;

  Results(
      {this.id,
      this.createdAt,
      this.width,
      this.height,
      this.color,
      this.likes,
      this.likedByUser,
      this.description,
      this.user,
      this.urls});

  Results.fromJson(Map<String, dynamic> json){
    this.id = json['id'];
    this.createdAt = json['created_at'];
    this.width = json['width'];
    this.height = json['height'];
    this.color = json['color'];
    this.likes = json['likes'];
    this.likedByUser = json['liked_by_user'];
    this.description = json['description'];
    this.user = json['user'] != null ? User.fromJson(json['user']) : null;
    this.urls = json['urls'] != null ? Urls.fromJson(json['urls']) : null;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt.toString(),
    "width": width,
    "height": height,
    "color": color,
    "likes": likes,
    "liked_by_user": likedByUser,
    "description": description,
    "user": user.toJson(),
    "urls": urls.toJson(),
  };

}

class User {
  String id;
  String username;
  String name;
  String firstName;
  String lastName;
  String instagramUsername;
  String twitterUsername;
  String portfolioUrl;
  ProfileImage profileImage;
  Links links;

  User(
      {this.id,
      this.username,
      this.name,
      this.firstName,
      this.lastName,
      this.twitterUsername,
      this.portfolioUrl,
      this.instagramUsername,
      this.links,
      this.profileImage});

  User.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.username = json['username'];
    this.name = json['name'];
    this.firstName = json['first_name'];
    this.lastName = json['last_name'];
    this.twitterUsername = json['twitter_username'];
    this.portfolioUrl = json['portfolio_url'];
    this.instagramUsername = json['instagram_username'];
    this.links = json['links'] != null ? Links.fromJson(json['links']) : null;
    this.profileImage = json['profile_image'] != null
        ? ProfileImage.fromJson(json['profile_image'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['twitter_username'] = this.twitterUsername;
    data['portfolio_url'] = this.portfolioUrl;
    data['instagram_username'] = this.instagramUsername;
    if (this.links != null) {
      data['links'] = this.links.toJson();
    }
    if (this.profileImage != null) {
      data['profile_image'] = this.profileImage.toJson();
    }
    return data;
  }
}

class Urls {
  String raw;
  String full;
  String regular;
  String small;
  String thumb;

  Urls({this.raw, this.full, this.regular, this.small, this.thumb});

  Urls.fromJson(Map<String, dynamic> json) {
    this.raw = json['raw'];
    this.full = json['full'];
    this.regular = json['regular'];
    this.small = json['small'];
    this.thumb = json['thumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['raw'] = this.raw;
    data['full'] = this.full;
    data['regular'] = this.regular;
    data['small'] = this.small;
    data['thumb'] = this.thumb;
    return data;
  }
}

class ProfileImage {
  String small;
  String medium;
  String large;

  ProfileImage({this.small, this.medium, this.large});

  ProfileImage.fromJson(Map<String, dynamic> json) {
    this.small = json['small'];
    this.medium = json['medium'];
    this.large = json['large'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['small'] = this.small;
    data['medium'] = this.medium;
    data['large'] = this.large;
    return data;
  }
}

class Links {
  String self;
  String html;
  String photos;
  String likes;

  Links({this.self, this.html, this.photos, this.likes});

  Links.fromJson(Map<String, dynamic> json) {
    this.self = json['self'];
    this.html = json['html'];
    this.photos = json['photos'];
    this.likes = json['likes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['self'] = this.self;
    data['html'] = this.html;
    data['photos'] = this.photos;
    data['likes'] = this.likes;
    return data;
  }
}
