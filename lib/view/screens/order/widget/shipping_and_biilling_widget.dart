import 'package:flutter/material.dart';
import 'package:sixvalley_vendor_app/data/model/response/order_model.dart';
import 'package:sixvalley_vendor_app/localization/language_constrants.dart';
import 'package:sixvalley_vendor_app/utill/color_resources.dart';
import 'package:sixvalley_vendor_app/utill/dimensions.dart';
import 'package:sixvalley_vendor_app/utill/images.dart';
import 'package:sixvalley_vendor_app/utill/styles.dart';
import 'package:sixvalley_vendor_app/view/screens/order/widget/edit_address_screen.dart';
import 'package:sixvalley_vendor_app/view/screens/order/widget/icon_with_text_row.dart';
import 'package:sixvalley_vendor_app/view/screens/order/widget/show_on_map_dialog.dart';

class ShippingAndBillingWidget extends StatelessWidget {
  final Order? orderModel;
  final bool? onlyDigital;
  final String orderType;
  const ShippingAndBillingWidget({Key? key, this.orderModel, this.onlyDigital, required this.orderType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(Images.mapBg), fit: BoxFit.cover)),
      child: Padding(padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [



          if(!onlyDigital!)Container(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeMedium),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: ThemeShadow.getShadow(context),
              borderRadius: const BorderRadius.vertical(top : Radius.circular(Dimensions.paddingSizeSmall))

            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [



              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  
                  Row(children: [
                    SizedBox(width: 20, child: Image.asset(Images.shippingIcon)),
                    Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                      child: Text('${getTranslated('address_info', context)}'))
                  ],),

                  orderType != 'POS' || !onlyDigital!?
                  GestureDetector(onTap: (){showDialog(context: context, builder: (_){
                        return const ShowOnMapDialog();
                      });
                    },
                    child: Row(children: [
                        Text('${getTranslated('show_on_map', context)}', style: robotoRegular.copyWith()),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                        Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                          child: Image.asset(Images.showOnMap, width: Dimensions.iconSizeDefault))])): const SizedBox(),
                ],),
              ),

              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(getTranslated('shipping', context)!, style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge,
                    color: ColorResources.titleColor(context),)),
                  InkWell(onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>
                     EditAddress(isBilling: false,
                       orderId: orderModel?.id.toString(),
                       address: orderModel!.shippingAddressData?.address,
                       city: orderModel!.shippingAddressData?.city,
                       zip: orderModel!.shippingAddressData?.zip,
                       name: orderModel!.shippingAddressData?.contactPersonName,
                       number: orderModel!.shippingAddressData?.phone,
                       email: orderModel!.shippingAddressData?.email,
                       lat: orderModel!.shippingAddressData?.latitude??'0',
                       lng: orderModel!.shippingAddressData?.longitude??'0',
                     )));
                  },
                      child: SizedBox(width: 20, child: Image.asset(Images.edit,color: Theme.of(context).primaryColor,))),
                ],
              ),

              const SizedBox(height: Dimensions.paddingSizeSmall),

              if(orderModel!.shippingAddressData != null)
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(child: IconWithTextRow(text: orderModel!.shippingAddressData?.contactPersonName??'',icon: Icons.person, bold: true,)),

                Expanded(child: IconWithTextRow(text: orderModel!.shippingAddressData?.phone??'',icon: Icons.call, bold: true,)),
              ],),
              const SizedBox(height: Dimensions.paddingSizeSmall),

              if(orderModel!.shippingAddressData != null && orderModel!.shippingAddressData?.email != null)
              IconWithTextRow(text: '${orderModel!.shippingAddressData?.email}',icon: Icons.email),

              if(orderModel!.shippingAddressData != null && orderModel!.shippingAddressData?.email != null)
              const SizedBox(height: Dimensions.paddingSizeSmall),

              IconWithTextRow(text: orderModel!.shippingAddressData?.address??'',icon: Icons.location_on, textColor: Theme.of(context).disabledColor,)





            ],
          ),),


          Container(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeMedium),
            decoration: BoxDecoration(color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.vertical(bottom : Radius.circular(Dimensions.paddingSizeSmall))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(getTranslated('billing', context)!, style: titilliumSemiBold.copyWith(fontSize: Dimensions.fontSizeLarge,
                    color: ColorResources.titleColor(context),)),
                  InkWell(onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (_)=>
                     EditAddress(isBilling: true,
                         orderId: orderModel?.id.toString(),
                     address: orderModel!.billingAddressData?.address??'',
                     city: orderModel!.billingAddressData?.city??'',
                     zip: orderModel!.billingAddressData?.zip??'',
                     name: orderModel!.billingAddressData?.contactPersonName??'',
                     email: orderModel!.billingAddressData?.email??'',
                     number: orderModel!.billingAddressData?.phone??'',
                       lat: orderModel!.billingAddressData?.latitude??'0',
                       lng: orderModel!.billingAddressData?.longitude??'0',
                     )));
                  },
                      child: SizedBox(width: 20, child: Image.asset(Images.edit,color: Theme.of(context).primaryColor,))),

                ],
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),


              Row(children: [
                Expanded(child: IconWithTextRow(text: orderModel!.billingAddressData != null ?
                orderModel!.billingAddressData?.contactPersonName?.trim()??''  : '',icon: Icons.person, bold: true,)),

                Expanded(child: IconWithTextRow(text: orderModel!.billingAddressData != null ?
                orderModel!.billingAddressData?.phone?.trim()??''  : '',icon: Icons.call, bold: true,)),
              ],),
              const SizedBox(height: Dimensions.paddingSizeSmall),

              if(orderModel!.billingAddressData?.email != null)
                IconWithTextRow(text: orderModel!.billingAddressData?.email?? '' ,icon: Icons.email),

              if(orderModel!.billingAddressData != null)
                const SizedBox(height: Dimensions.paddingSizeSmall),

              IconWithTextRow(text: orderModel!.billingAddressData != null ?
              orderModel!.billingAddressData?.address?.trim()??'' : '',icon: Icons.location_on)
            ],),
          ),

        ]),
      ),
    );
  }
}
