import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/provider/edits_repo.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';

class ChangeColorCategory extends StatelessWidget {
  const ChangeColorCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Color Picker Demo'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Consumer<SliderRepo>(builder: (context, provider, _) {
                return FutureBuilder(
                    future: provider.fetch_Categoey(
                        AppConstants.editsBaseUrl + AppConstants.getCategory),
                    builder: (context, s) {
                      return ListView.builder(
                          itemCount: provider.categories.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 80,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 236, 233, 233),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(provider.categories[index].title
                                          .toString()),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              context
                                                      .read<SliderRepo>()
                                                      .categorytitle =
                                                  provider
                                                      .categories[index].title
                                                      .toString();
                                              provider.delete_story(
                                                  AppConstants.editsBaseUrl +
                                                      AppConstants
                                                          .deleteCategory,
                                                  provider.categories[index].id
                                                      .toString());

                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title:
                                                        Text('Pick a color!'),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: ColorPicker(
                                                        pickerColor:
                                                            colorProvider
                                                                .selectedColor,
                                                        onColorChanged:
                                                            (Color color) {
                                                          colorProvider
                                                              .changeColor(
                                                                  color);
                                                          context
                                                              .read<
                                                                  SliderRepo>()
                                                              .color = color.value;
                                                        },
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: Text('Got it'),
                                                        onPressed: () {
                                                          Provider.of<SliderRepo>(
                                                                  context,
                                                                  listen: false)
                                                              .postTitleAndCategory();
                                                          Provider.of<SliderRepo>(
                                                                  context,
                                                                  listen: false)
                                                              .fetch_Categoey(AppConstants
                                                                      .editsBaseUrl +
                                                                  AppConstants
                                                                      .getCategory);
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Container(
                                              height: 70,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Color(int.parse(provider
                                                    .categories[index].color
                                                    .toString())),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              provider.delete_story(
                                                  AppConstants.editsBaseUrl +
                                                      AppConstants
                                                          .deleteCategory,
                                                  provider.categories[index].id
                                                      .toString());
                                            },
                                            child: Container(
                                              height: 70,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.grey,
                                              ),
                                              child: Icon(
                                                Icons.cancel_outlined,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      // InkWell(
                                      //   onTap: () {
                                      //     showDialog(
                                      //       context: context,
                                      //       builder: (BuildContext context) {
                                      //         return AlertDialog(
                                      //           title: Text('Pick a color!'),
                                      //           content: SingleChildScrollView(
                                      //             child: ColorPicker(
                                      //               pickerColor:
                                      //                   colorProvider.selectedColor,
                                      //               onColorChanged: (Color color) {
                                      //                 colorProvider
                                      //                     .changeColor(color);
                                      //                 context
                                      //                     .read<SliderRepo>()
                                      //                     .color = color.value;
                                      //               },
                                      //             ),
                                      //           ),
                                      //           actions: <Widget>[
                                      //             Padding(
                                      //               padding:
                                      //                   const EdgeInsets.symmetric(
                                      //                       horizontal: 20,
                                      //                       vertical: 10),
                                      //               child: TextFormField(
                                      //                 onChanged: (value) {
                                      //                   context
                                      //                           .read<SliderRepo>()
                                      //                           .categorytitle =
                                      //                       value.toString();
                                      //                 },
                                      //                 decoration: const InputDecoration(
                                      //                     hintText: "Add Group Name",
                                      //                     border:
                                      //                         OutlineInputBorder()),
                                      //               ),
                                      //             ),
                                      //             TextButton(
                                      //               child: Text('Got it'),
                                      //               onPressed: () {
                                      //                 Provider.of<SliderRepo>(context,
                                      //                         listen: false)
                                      //                     .postTitleAndCategory();
                                      //                 Provider.of<SliderRepo>(context,
                                      //                         listen: false)
                                      //                     .fetch_Categoey(AppConstants
                                      //                             .editsBaseUrl +
                                      //                         AppConstants
                                      //                             .getCategory);
                                      //                 Navigator.of(context).pop();
                                      //               },
                                      //             ),
                                      //           ],
                                      //         );
                                      //       },
                                      //     );
                                      //   },
                                      //   child: Container(
                                      //     height: 70,
                                      //     width: 70,
                                      //     decoration: BoxDecoration(
                                      //       borderRadius: BorderRadius.circular(20),
                                      //       color: Color(int.parse(provider
                                      //           .categories[index].color
                                      //           .toString())),
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }));
                    });
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: ColorResources.homeBg,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Pick a color!'),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: colorProvider.selectedColor,
                    onColorChanged: (Color color) {
                      colorProvider.changeColor(color);
                      context.read<SliderRepo>().color = color.value;
                    },
                  ),
                ),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: TextFormField(
                      onChanged: (value) {
                        context.read<SliderRepo>().categorytitle =
                            value.toString();
                      },
                      decoration: const InputDecoration(
                          hintText: "Add Group Name",
                          border: OutlineInputBorder()),
                    ),
                  ),
                  TextButton(
                    child: Text('Got it'),
                    onPressed: () {
                      Provider.of<SliderRepo>(context, listen: false)
                          .postTitleAndCategory();
                      Provider.of<SliderRepo>(context, listen: false)
                          .fetch_Categoey(AppConstants.editsBaseUrl +
                              AppConstants.getCategory);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          color: ColorResources.floatingBtn,
        ),
      ),
    );
  }
}
