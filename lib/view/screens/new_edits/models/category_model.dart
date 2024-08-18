class SliderModel {
  int? id;
  String? title;
  String? category;
  String? creationDateTime;
  Links? lLinks;

  SliderModel(
      {this.id, this.title, this.category, this.creationDateTime, this.lLinks});

  SliderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    category = json['category'];
    creationDateTime = json['creationDateTime'];
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
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
  Self? categoricalSliders;

  Links({this.self, this.categoricalSliders});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'] != null ? new Self.fromJson(json['self']) : null;
    categoricalSliders = json['categorical-sliders'] != null
        ? new Self.fromJson(json['categorical-sliders'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self!.toJson();
    }
    if (this.categoricalSliders != null) {
      data['categorical-sliders'] = this.categoricalSliders!.toJson();
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
