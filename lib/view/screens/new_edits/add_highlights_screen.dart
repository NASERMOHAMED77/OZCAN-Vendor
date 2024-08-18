// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/provider/edits_repo.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';

import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/view/base/custom_bottom_sheet.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';
import 'package:sixvalley_vendor_app/view/screens/new_edits/add_story_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/new_edits/models/story_model.dart';

class AddToHighLightsScreen extends StatefulWidget {
  const AddToHighLightsScreen({Key? key}) : super(key: key);

  @override
  State<AddToHighLightsScreen> createState() => _AddToHighLightsScreenState();
}

class _AddToHighLightsScreenState extends State<AddToHighLightsScreen> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingControllerCategory = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<SliderRepo>(builder: (context, provider, _) {
      return Scaffold(
          appBar: AppBar(
            title: Text("HighLigths"),
          ),
          floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ColorResources.homeBg,
            
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text("Category Name"),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: TextFormField(
                                onChanged: (value) {
                                  context.read<SliderRepo>().category =
                                      value.toString().toUpperCase();
                                  print(provider.title);
                                },
                                controller: textEditingControllerCategory,
                                decoration: const InputDecoration(
                                    hintText: "Add Caregory Name",
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Text("Group Name"),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: TextFormField(
                                onChanged: (value) {
                                  context.read<SliderRepo>().title =
                                      value.toString();
                                  print(provider.title);
                                },
                                controller: textEditingController,
                                decoration: const InputDecoration(
                                    hintText: "Add Group Name",
                                    border: OutlineInputBorder()),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: CustomBottomSheet(
                                      image: "assets/image/ss.jpg",
                                      title: "Video",
                                      onTap: () {
                                        provider.uploadImageOrVideo(
                                          AppConstants.editsBaseUrl +
                                              AppConstants.uploadHighLigths,
                                          AppConstants.editsBaseUrl +
                                              AppConstants.getStory,
                                          "VIDEO",
                                        );
                                                                                 Navigator.pop(context);

                                      }),
                                ),
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: CustomBottomSheet(
                                      image: "assets/image/ss.jpg",
                                      title: "Image",
                                      onTap: () {
                                        provider.uploadImageOrVideo(
                                            AppConstants.editsBaseUrl +
                                                AppConstants.uploadHighLigths,
                                            AppConstants.editsBaseUrl +
                                                AppConstants.getHighLigths,
                                            "IMAGE");
                                        Navigator.pop(context);
                                      }),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              },
              shape: CircleBorder(),
              label: const Icon(
                Icons.add,
                size: 30,
                color: Colors.black,
              )),
          body: SafeArea(
            child: SingleChildScrollView(
              child: FutureBuilder(
                  future: provider.fetch_highLigths(
                      AppConstants.editsBaseUrl + AppConstants.getHighLigths),
                  builder: (context, s) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                          ),
                          itemCount: provider.categoryTitle.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Text(provider.categoryTitle[index]),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .2,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: provider.highLigthsImages
                                          .where((element) =>
                                              element.category ==
                                              provider.categoryTitle[index])
                                          .toList()
                                          .length,
                                      itemBuilder: ((context, indexlist) {
                                        return provider.highLigthsImages
                                                    .where((element) =>
                                                        element.category ==
                                                        provider.categoryTitle[
                                                            index])
                                                    .toList()[indexlist]
                                                    .content
                                                    .toString() ==
                                                "IMAGE"
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      child: CustomImage(
                                                        image: provider
                                                            .highLigthsImages
                                                            .where((element) =>
                                                                element
                                                                    .category ==
                                                                provider.categoryTitle[
                                                                    index])
                                                            .toList()[indexlist]
                                                            .lLinks!
                                                            .self!
                                                            .href
                                                            .toString(),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    Positioned(
                                                      child: InkWell(
                                                        onTap: () {
                                                          // showDialog(context: context, builder: (conttex){
                                                          //   return AlertDialog(content: Container(child: ElevatedButton(onPressed: (){
                                                          //                             Provider.of<SliderRepo>(context).delete_story(url, id)

                                                          //   }, child: Text("Delete story")),),);
                                                          // })
                                                          provider.delete_story(
                                                              AppConstants
                                                                      .editsBaseUrl +
                                                                  AppConstants
                                                                      .deleteHighLigths,
                                                              provider
                                                                  .highLigthsImages
                                                                  .where((element) =>
                                                                      element
                                                                          .category ==
                                                                      provider.categoryTitle[
                                                                          index])
                                                                  .toList()[
                                                                      indexlist]
                                                                  .id
                                                                  .toString());
                                                        },
                                                        child: Icon(
                                                          Icons.cancel,
                                                          color: Colors.blue,
                                                          size: 40,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ))
                                            : Stack(
                                                children: [
                                                  InkWell(
                                                    onTap: (() {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  ((context) =>
                                                                      MoreStories(
                                                                        listofstories: provider
                                                                            .highLigthsImages
                                                                            .where((element) =>
                                                                                element.category ==
                                                                                provider.categoryTitle[index])
                                                                            .toList()[indexlist]
                                                                            .lLinks!
                                                                            .self!
                                                                            .href
                                                                            .toString(),
                                                                      ))));
                                                    }),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Image.asset(
                                                          'assets/image/vph.png'),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    child: InkWell(
                                                      onTap: () {
                                                        // showDialog(context: context, builder: (conttex){
                                                        //   return AlertDialog(content: Container(child: ElevatedButton(onPressed: (){
                                                        //                             Provider.of<SliderRepo>(context).delete_story(url, id)

                                                        //   }, child: Text("Delete story")),),);
                                                        // })
                                                        provider.delete_story(
                                                            AppConstants
                                                                    .editsBaseUrl +
                                                                AppConstants
                                                                    .deleteHighLigths,
                                                            provider
                                                                .highLigthsImages
                                                                .where((element) =>
                                                                    element
                                                                        .category ==
                                                                    provider.categoryTitle[
                                                                        index])
                                                                .toList()[
                                                                    indexlist]
                                                                .id
                                                                .toString());
                                                      },
                                                      child: Icon(
                                                        Icons.cancel,
                                                        color: Colors.blue,
                                                        size: 40,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              );
                                      })),
                                )
                              ],
                            );
                          }),
                    );
                  }),
            ),
          ));
    });
  }
}

class HIghLigthModel {
  int? id;
  String? title;
  String? content;
  String? category;
  Null? highlightGroupId;
  String? creationDateTime;
  Links? lLinks;

  HIghLigthModel(
      {this.id,
      this.title,
      this.content,
      this.category,
      this.highlightGroupId,
      this.creationDateTime,
      this.lLinks});

  HIghLigthModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    category = json['category'];
    highlightGroupId = json['highlightGroupId'];
    creationDateTime = json['creationDateTime'];
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['category'] = this.category;
    data['highlightGroupId'] = this.highlightGroupId;
    data['creationDateTime'] = this.creationDateTime;
    if (this.lLinks != null) {
      data['_links'] = this.lLinks!.toJson();
    }
    return data;
  }
}

class Links {
  Self? self;
  HighlightGroup? highlightGroup;
  Self? highlights;

  Links({this.self, this.highlightGroup, this.highlights});

  Links.fromJson(Map<String, dynamic> json) {
    self = json['self'] != null ? new Self.fromJson(json['self']) : null;
    highlightGroup = json['highlightGroup'] != null
        ? new HighlightGroup.fromJson(json['highlightGroup'])
        : null;
    highlights = json['highlights'] != null
        ? new Self.fromJson(json['highlights'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.self != null) {
      data['self'] = this.self!.toJson();
    }
    if (this.highlightGroup != null) {
      data['highlightGroup'] = this.highlightGroup!.toJson();
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

class HighlightGroup {
  String? href;
  bool? templated;

  HighlightGroup({this.href, this.templated});

  HighlightGroup.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    templated = json['templated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    data['templated'] = this.templated;
    return data;
  }
}
