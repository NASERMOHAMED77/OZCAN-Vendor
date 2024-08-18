class StoriesModel {
  int? id;
  String? title;
  String? content;
  String? category;
  String? creationDateTime;
  Links? lLinks;

  StoriesModel(
      {this.id,
      this.title,
      this.content,
      this.category,
      this.creationDateTime,
      this.lLinks});

  StoriesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    category = json['category'];
    creationDateTime = json['creationDateTime'];
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['category'] = this.category;
    data['creationDateTime'] = this.creationDateTime;
    if (this.lLinks != null) {
      data['_links'] = this.lLinks!.toJson();
    }
    return data;
  }
}

class Links {
  Self? self;
  Self? stories;

  Links({this.self, this.stories});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'] != null ? new Self.fromJson(json['self']) : null;
    stories =
        json['stories'] != null ? new Self.fromJson(json['stories']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self!.toJson();
    }
    if (this.stories != null) {
      data['stories'] = this.stories!.toJson();
    }
    return data;
  }
}

class Self {
  String? href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}
