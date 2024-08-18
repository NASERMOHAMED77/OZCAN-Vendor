
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sixvalley_vendor_app/provider/edits_repo.dart';
import 'package:sixvalley_vendor_app/utill/app_constants.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';

class AddToMainSliderScreen extends StatefulWidget {
  const AddToMainSliderScreen({Key? key}) : super(key: key);

  @override
  State<AddToMainSliderScreen> createState() => _AddToMainSliderScreenState();
}

class _AddToMainSliderScreenState extends State<AddToMainSliderScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SliderRepo>(builder: (context, provider, _) {
      return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              provider.uploadImage(
                  AppConstants.editsBaseUrl + AppConstants.uploadMainSlider,
                  AppConstants.editsBaseUrl + AppConstants.getMainSlider);
            },
            
            label: const Icon(
              Icons.add,
              size: 30,
              color: Colors.black,
            )),
            appBar: AppBar(
            title: Text("Main Slider"),
          ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: provider.fetch_Slider(
                      AppConstants.editsBaseUrl + AppConstants.getMainSlider),
                  builder: (context, snapshot) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: GridView.builder(
                          itemCount: provider.sliderImages.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
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
                                          placeholder: AssetImage(
                                              Images.placeholderImage),
                                          image: NetworkImage(provider
                                              .sliderImages[index]
                                              .lLinks!
                                              .self!
                                              .href
                                              .toString()))),
                                  Positioned(
                                    right: 5,
                                    top: 5,
                                    child: GestureDetector(
                                      onTap: () async {
                                        provider.delete_story(
                                          AppConstants.editsBaseUrl +
                                              AppConstants.deleteMainSlider,
                                          provider.sliderImages[index].id
                                              .toString(),
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
                  })
            ],
          ),
        )),
      );
    });
  }
}
