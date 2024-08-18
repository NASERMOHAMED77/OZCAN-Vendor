import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/provider/edits_repo.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/base/custom_bottom_sheet.dart';
import 'package:sixvalley_vendor_app/view/base/custom_image.dart';
import 'package:sixvalley_vendor_app/view/screens/new_edits/models/category_model.dart';

class AddToCategorySliderScreen extends StatelessWidget {
  const AddToCategorySliderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    return Consumer<SliderRepo>(builder: (context, provider, _) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Add Slider Image"),
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
                                      value.trim();
                                  print(provider.title);
                                },
                                controller: textEditingController,
                                decoration: const InputDecoration(
                                    hintText: "Add Category Name",
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
                                      title: "Image",
                                      onTap: () {
                                        provider.uploadImageOrVideo(
                                            AppConstants.editsBaseUrl +
                                                AppConstants
                                                    .uploadCategorySlidermain,
                                            AppConstants.editsBaseUrl +
                                                AppConstants.getCategorySlider,
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
                  future: provider.fetch_CategorySlider(
                      AppConstants.editsBaseUrl + AppConstants.getMainSlider),
                  builder: (context, s) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                          ),
                          itemCount: provider.categoryTitleSliders.length,
                          itemBuilder: (context, index) {
                            print(provider.categoryTitleSliders.length);
                            return Column(
                              children: [
                                Text(provider.categoryTitleSliders[index]),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .2,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: provider.categorySliderImages
                                          .where((element) =>
                                              element.category ==
                                              provider
                                                  .categoryTitleSliders[index])
                                          .toList()
                                          .length,
                                      itemBuilder: ((context, indexlist) {
                                        return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Stack(
                                              children: [
                                                Container(
                                                  child: CustomImage(
                                                    image: provider
                                                        .categorySliderImages
                                                        .where((element) =>
                                                            element.category ==
                                                            provider.categoryTitleSliders[
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
                                                                  .deleteMainSlider,
                                                          provider
                                                              .categorySliderImages
                                                              .where((element) =>
                                                                  element
                                                                      .category ==
                                                                  provider.categoryTitleSliders[
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
                                            ));
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

class SlidersView extends StatelessWidget {
  const SlidersView({Key? key, required this.count, required this.images})
      : super(key: key);
  final int count;
  final List<SliderModel> images;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
          itemCount: count,
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1),
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: FadeInImage(
                          fit: BoxFit.contain,
                          placeholder: AssetImage(Images.placeholderImage),
                          image: NetworkImage(
                              images[index].lLinks!.self!.href.toString()))),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: GestureDetector(
                      onTap: () async {
                        Provider.of<SliderRepo>(context, listen: false)
                            .delete_story(
                          AppConstants.editsBaseUrl +
                              AppConstants.deleteMainSlider,
                          images[index].id.toString(),
                        );
                      },
                      child: Icon(
                        Icons.cancel,
                        color: Colors.blue,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            );
          })),
    );
  }
}
