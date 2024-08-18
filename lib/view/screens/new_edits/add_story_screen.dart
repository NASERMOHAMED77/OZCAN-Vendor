// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';
import 'package:story_view/story_view.dart';

import 'package:sixvalley_vendor_app/provider/edits_repo.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/view/base/custom_bottom_sheet.dart';
import 'package:sixvalley_vendor_app/view/screens/new_edits/models/story_model.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AddStoryScreen extends StatefulWidget {
  AddStoryScreen({Key? key}) : super(key: key);

  @override
  State<AddStoryScreen> createState() => _AddStoryScreenState();
}

class _AddStoryScreenState extends State<AddStoryScreen> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingControllerCategory = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<SliderRepo>(builder: (context, provider, _) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Add Story"),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                onSaved: (value) {
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
                                              AppConstants.uploadStory,
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
                                              AppConstants.uploadStory,
                                          AppConstants.editsBaseUrl +
                                              AppConstants.getStory,
                                          "IMAGE",
                                        );
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
              shape: const CircleBorder(),
              label: const Icon(
                Icons.add,
                size: 30,
                color: Colors.black,
              )),
          body: SafeArea(
            child: SingleChildScrollView(
              child: FutureBuilder(
                  future: provider.fetch_story(
                      AppConstants.editsBaseUrl + AppConstants.getStory),
                  builder: (context, s) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                          ),
                          itemCount: provider.categoryTitleStory.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Text(provider.categoryTitleStory[index]),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .2,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: provider.image
                                          .where((element) =>
                                              element.category ==
                                              provider
                                                  .categoryTitleStory[index])
                                          .toList()
                                          .length,
                                      itemBuilder: ((context, indexlist) {
                                        return provider.image
                                                    .where((element) =>
                                                        element.category ==
                                                        provider.categoryTitleStory[
                                                            index])
                                                    .toList()[indexlist]
                                                    .content ==
                                                "IMAGE"
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      child: CustomImage(
                                                        image: provider.image
                                                            .where((element) =>
                                                                element
                                                                    .category ==
                                                                provider.categoryTitleStory[
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
                                                                      .deletestory,
                                                              provider.image
                                                                  .where((element) =>
                                                                      element
                                                                          .category ==
                                                                      provider.categoryTitleStory[
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
                                                                            .image
                                                                            .where((element) =>
                                                                                element.category ==
                                                                                provider.categoryTitleStory[index])
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
                                                                    .deletestory,
                                                            provider.image
                                                                .where((element) =>
                                                                    element
                                                                        .category ==
                                                                    provider.categoryTitleStory[
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

class MoreStories extends StatefulWidget {
  MoreStories({
    Key? key,
    required this.listofstories,
  }) : super(key: key);

  final String listofstories;

  @override
  _MoreStoriesState createState() => _MoreStoriesState();
}

class _MoreStoriesState extends State<MoreStories> {
  final storyController = StoryController();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int x = 0;
    return Scaffold(
      body: SizedBox(
          child: Stack(
        children: [
          StoryView(
            storyItems: [
              StoryItem.pageVideo(widget.listofstories.toString(),
                  duration: Duration(seconds: 30),
                  controller: StoryController())
            ],
            onStoryShow: (storyItem, index) {
              print("Showing a story");
              x = index;
            },
            onComplete: () {
              Navigator.pop(context);
              print("Completed a cycle");
            },
            progressPosition: ProgressPosition.top,
            repeat: false,
            controller: storyController,
          ),
        ],
      )),
    );
  }
}

class DElete extends StatelessWidget {
  const DElete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class VideoToImage extends StatefulWidget {
  final String videoUrl;

  VideoToImage({required this.videoUrl});

  @override
  _VideoToImageState createState() => _VideoToImageState();
}

class _VideoToImageState extends State<VideoToImage> {
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _generateThumbnail();
  }

  Future<void> _generateThumbnail() async {
    final thumbnailPath =
        (await getTemporaryDirectory()).path + '/thumbnail.png';

    await VideoThumbnail.thumbnailFile(
      video: widget.videoUrl,
      thumbnailPath: thumbnailPath,
      imageFormat: ImageFormat.PNG,
      maxHeight: 200,
      maxWidth: 200,
    );

    setState(() {
      _imageUrl = thumbnailPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _imageUrl != null
        ? Image.file(
            File(_imageUrl!),
            fit: BoxFit.cover,
          )
        : Center(child: CircularProgressIndicator());
  }
}
