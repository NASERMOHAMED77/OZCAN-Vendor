class HighLigthsModel {
  int? id;
  String? title;
  String? creationDateTime;
  Links? lLinks;

  HighLigthsModel({this.id, this.title, this.creationDateTime, this.lLinks});

  HighLigthsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    creationDateTime = json['creationDateTime'];
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['creationDateTime'] = this.creationDateTime;
    if (this.lLinks != null) {
      data['_links'] = this.lLinks!.toJson();
    }
    return data;
  }
}

class Links {
  Self? self;
  Self? highlights;

  Links({this.self, this.highlights});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'] != null ? new Self.fromJson(json['self']) : null;
    highlights = json['highlights'] != null
        ? new Self.fromJson(json['highlights'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self!.toJson();
    }
    if (this.highlights != null) {
      data['highlights'] = this.highlights!.toJson();
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