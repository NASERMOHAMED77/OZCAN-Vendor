// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';
import 'package:sixvalley_vendor_app/view/screens/new_edits/add_highlights_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/new_edits/models/category_model.dart';
import 'package:sixvalley_vendor_app/view/screens/new_edits/models/story_model.dart';

class SliderRepo extends ChangeNotifier {
  List<StoriesModel> image = [];
  Map<String, List<StoriesModel>> mapStories = {};
  int storiescount = 0;
  List<StoryModel> sliderImages = [];
  List<SliderModel> categorySliderImages = [];
  List<HIghLigthModel> highLigthsImages = [];
  bool isloading = false;
  Map<String, List<HIghLigthModel>> gruop = {};
  List<HIghLigthModel> xx = [];
  List<CategoryModel> categories = [];
  String categorytitle = "MEN";
  int color = 4287652321;

  fetch_Categoey(String url) async {
    var response = await http.get(Uri.parse(url));
    categories = [];
    if (response.statusCode == 200) {
      try {
        for (var element in json.decode(response.body)) {
          categories.add(CategoryModel.fromJson(element));
        }
        notifyListeners();
      } catch (e) {
        print(e);
      }
      print('Response status: ${response.statusCode}');
    } else {
      print('Response status: ${response.statusCode}');

      print('Failed to load data');
    }
  }

  Future<void> postTitleAndCategory() async {
    final body = jsonEncode(
        {"title": categorytitle.toUpperCase(), "color": color.toString()});

    try {
      final response = await http.post(
          Uri.parse(AppConstants.editsBaseUrl + AppConstants.uploadCategory),
          body: body,
          headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 201) {
        print('Title and category posted successfully!');
      } else {
        print('Error posting title and category: ${response.statusCode}');
      }
    } catch (e) {
      print('Error posting title and category: $e');
    }
  }

  Future<String> uploadImage(String url, String urlGet) async {
    final file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    final filePath = file!.files.first.path;
    final fileBytes = await File(filePath!).readAsBytes();
    final fileMime = lookupMimeType(filePath);

    final uri = Uri.parse(url);
    final request = http.MultipartRequest('POST', uri);

    request.files.add(http.MultipartFile.fromBytes(
      'file',
      fileBytes,
      filename: filePath.split('/').last,
      contentType: MediaType.parse(fileMime!),
    ));

    final response = await request.send();
    notifyListeners();
    if (response.statusCode == 200) {
      print('Image uploaded successfully');
      notifyListeners();
      fetch_story(urlGet);
      return 'Image uploaded successfully';
    } else {
      print('Failed to upload image' + response.statusCode.toString());
      notifyListeners();

      return 'Failed to upload image';
    }
  }

  String category = "MEN";
  String title = "OZCAN";
  Future<String> uploadImageOrVideo(
    String url,
    String urlGet,
    String isvedio,
  ) async {
    isloading = true;
    final file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'MP4'],
    );
    final filePath = file!.files.first.path;
    final fileBytes = await File(filePath!).readAsBytes();
    final fileMime = lookupMimeType(filePath);

    final uri = Uri.parse(url);
    final request = http.MultipartRequest('POST', uri);

    request.files.add(http.MultipartFile.fromBytes(
      'file',
      fileBytes,
      filename: filePath.split('/').last,
      contentType: MediaType.parse(fileMime!),
    ));
    request.fields["contentType"] = isvedio.toString();
    request.fields["category"] = category.toString().toUpperCase().trim();
    request.fields["title"] = title.toString().trim();
    final response = await request.send();
    notifyListeners();
    if (response.statusCode == 200) {
      print('Image uploaded successfully');
      isloading = false;
      notifyListeners();
      fetch_story(urlGet);
      return 'Image uploaded successfully';
    } else {
      isloading = false;

      print('Failed to upload image' + response.statusCode.toString());
      notifyListeners();

      return 'Failed to upload image';
    }
  }

  List categoryTitleStory = [];
  fetch_story(String url) async {
    var response = await http.get(Uri.parse(url));
    image = [];
    mapStories = {};
    storiescount = 0;
    categoryTitleStory = [];
    List<StoriesModel> x;
    if (response.statusCode == 200) {
      try {
        for (var element in json.decode(response.body)["_embedded"]
            ["storyResponseList"]) {
          image.add(StoriesModel.fromJson(element));
        }
        for (var element in image) {
          x = [];
          for (var i = 0; i < image.length; i++) {
            if (element.title == image[i].title) {
              x.add(image[i]);
            }
            if (categoryTitleStory.contains(element.category)) {
            } else {
              categoryTitleStory.add(element.category);
            }
          }

          mapStories.addAll({storiescount.toString(): x});
          storiescount++;
        }

        notifyListeners();
      } catch (e) {
        print(e);
      }
      print('Response status: ${response.statusCode}');
    } else {
      print('Failed to load data');
    }
  }

  fetch_Slider(String url) async {
    var response = await http.get(Uri.parse(url));
    sliderImages = [];
    if (response.statusCode == 200) {
      try {
        for (var element in json.decode(response.body)["_embedded"]
            ["sliderResponseList"]) {
          sliderImages.add(StoryModel.fromJson(element));
        }
        notifyListeners();
      } catch (e) {
        print(e);
      }
      print('Response status: ${response.statusCode}');
    } else {
      print('Response status: ${response.statusCode}');

      print('Failed to load data');
    }
  }

  List categoryTitleSliders = [];

  fetch_CategorySlider(String url) async {
    var response = await http.get(Uri.parse(url));
    categorySliderImages = [];
    categoryTitleSliders = [];

    if (response.statusCode == 200) {
      try {
        for (var element in json.decode(response.body)["_embedded"]
            ["categoricalSliderResponseList"]) {
          categorySliderImages.add(SliderModel.fromJson(element));
          if (categoryTitleSliders
              .contains(SliderModel.fromJson(element).category)) {
          } else {
            categoryTitleSliders.add(SliderModel.fromJson(element).category);
          }
        }
        for (var element in categorySliderImages) {}
        print(categoryTitleSliders);
        notifyListeners();
      } catch (e) {
        print(e);
      }
      print('Response status: ${response.statusCode}');
    } else {
      print('Response status: ${response.statusCode}');

      print('Failed to load data');
    }
  }

  List categoryTitle = [];
  fetch_highLigths(String url) async {
    var response = await http.get(Uri.parse(url));
    highLigthsImages = [];
    gruop = {};
    int x = 0;
    xx = [];
    categoryTitle = [];
    if (response.statusCode == 200) {
      try {
        for (var element in json.decode(response.body)["_embedded"]
            ["highlightResponseList"]) {
          highLigthsImages.add(HIghLigthModel.fromJson(element));
          xx.add(highLigthsImages[x]);
          gruop[highLigthsImages[x].title.toString()] = xx
              .where((element) =>
                  element.title == highLigthsImages[x].title.toString())
              .toList();
          if (categoryTitle.contains(highLigthsImages[x].category)) {
          } else {
            categoryTitle.add(highLigthsImages[x].category);
          }
          x++;
        }

        notifyListeners();
      } catch (e) {
        print(e);
      }

      print('Response status: ${response.statusCode}');
    } else {
      print('Response status: ${response.statusCode}');

      print('Failed to load data');
    }
  }

  delete_story(String url, String id) async {
    var response = await http.delete(Uri.parse(url + id.toString()));

    if (response.statusCode == 200) {
      print('Response status: ${response.statusCode}');
    } else {
      print('Response status: ${response.statusCode}');
    }
  }
}

class StoryModel {
  int? id;
  String? title;
  String? creationDateTime;
  Links? lLinks;

  StoryModel({this.id, this.title, this.creationDateTime, this.lLinks});

  StoryModel.fromJson(Map<String, dynamic> json) {
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
  Self? sliders;

  Links({this.self, this.sliders});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'] != null ? new Self.fromJson(json['self']) : null;
    sliders =
        json['sliders'] != null ? new Self.fromJson(json['sliders']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self!.toJson();
    }
    if (this.sliders != null) {
      data['sliders'] = this.sliders!.toJson();
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

class ColorProvider with ChangeNotifier {
  Color _selectedColor = Colors.blue; // Default color

  Color get selectedColor => _selectedColor;

  void changeColor(Color color) {
    _selectedColor = color;
    notifyListeners();
  }
}

class CategoryModel {
  int? id;
  String? title;
  String? color;

  CategoryModel({this.id, this.title, this.color});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['color'] = this.color;
    return data;
  }
}
