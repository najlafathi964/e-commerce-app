import 'package:flutter/material.dart';
import 'package:food_delivary_app/controllers/auth_controller.dart';
import 'package:food_delivary_app/controllers/user_controller.dart';
import 'package:food_delivary_app/helper/route_helper.dart';
import 'package:food_delivary_app/models/address_model.dart';
import 'package:food_delivary_app/screens/address/pick_address_map.dart';
import 'package:food_delivary_app/shared/app_colors.dart';
import 'package:food_delivary_app/shared/componants.dart';
import 'package:food_delivary_app/shared/dimenstion.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/location_controller.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonNameController = TextEditingController();
  final TextEditingController _contactPersonNumberController = TextEditingController();
  late bool _isLogged ;
  CameraPosition _cameraPosition = CameraPosition(target: LatLng(
    45.51563 , -122.677433
  ), zoom: 17);
  late LatLng _initialPosition = LatLng(
      45.51563 , -122.677433
  );

  @override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if(_isLogged&&Get.find<UserController>().userModel==null){
      Get.find<UserController>().getUserInfo();
    }
    if(Get.find<LocationController>().addressList.isNotEmpty){
      if(Get.find<LocationController>().getUserAddressFromLocalStorage()==''){
        Get.find<LocationController>().saveUserAddress(Get.find<LocationController>().addressList.last);
      }
      Get.find<LocationController>().getUserAddress();
      _cameraPosition =CameraPosition(target: LatLng(
          double.parse(Get.find<LocationController>().getAddress['latitude']),
          double.parse(Get.find<LocationController>().getAddress['longitude'])

      ));
      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress['latitude']),
          double.parse(Get.find<LocationController>().getAddress['longitude'])

      ) ;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context, title: 'Address'),
      body: GetBuilder<UserController>(
        builder: (userController){
          if(userController.userModel!=null && _contactPersonNameController.text.isEmpty){
            _contactPersonNameController.text ='${userController.userModel.name}' ;
            _contactPersonNumberController.text = '${userController.userModel.phone}';
            if(Get.find<LocationController>().addressList.isNotEmpty){
             _addressController.text = Get.find<LocationController>().getUserAddress().address;
            }
          }
          return GetBuilder<LocationController>(
            builder: (locationController){
              _addressController.text='${locationController.placemark.name??''}'
                  '${locationController.placemark.locality??''}'
                  '${locationController.placemark.postalCode??''}'
                  '${locationController.placemark.country??''}' ;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5 ,right: 5 ,top: 5),
                      height: Dimenstions.height20*7,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 2 , color: AppColors.mainColor)
                      ),
                      child: Stack(
                        children: [
                          GoogleMap(initialCameraPosition: CameraPosition(target: _initialPosition , zoom: 17),
                            onTap: (latlng){
                            Get.toNamed(RouteHelper.getPickAddressMap() ,
                            arguments: PickAddressMap(
                              fromSignup: false ,
                              fromAddress: true ,
                              googleMapController: locationController.mapController,
                            ));
                            },
                            zoomControlsEnabled: false,
                            compassEnabled: false,
                            indoorViewEnabled: true,
                            mapToolbarEnabled: false,
                            myLocationEnabled: true,
                            onCameraIdle: (){
                              locationController.updatePosition(_cameraPosition , true);
                            },
                            onCameraMove: ((position)=>_cameraPosition=position),
                            onMapCreated: (GoogleMapController controller){
                              locationController.setMapController(controller);

                            },
                          ) ,
                        ],
                      ),
                    ) ,
                    Padding(
                      padding:  EdgeInsets.only(left: Dimenstions.width20 , top: Dimenstions.height20),
                      child: SizedBox(height: 50,child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: locationController.addressTypeList.length,
                          itemBuilder: (contrxt,index){
                        return InkWell(
                            onTap:(){
                              locationController.setAddressTypeIndex(index);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: Dimenstions.width20 , vertical: Dimenstions.height10),
                              margin: EdgeInsets.only(right: Dimenstions.width10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimenstions.radius20/4) ,
                                color: Theme.of(context).cardColor ,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[200]! ,
                                    spreadRadius: 1 ,
                                    blurRadius: 5 ,
                                  )
                                ]
                              ),
                                child: Icon(
                                  index == 0 ? Icons.home_filled
                                      :index == 1 ?Icons.work : Icons.location_on ,
                                  color: locationController.addressTypeIndex == index 
                                  ?AppColors.mainColor 
                                  :Theme.of(context).disabledColor
                                )));
                          })
                        ,),
                    ),
                    SizedBox(height : Dimenstions.height20) ,
                    Padding(
                      padding:  EdgeInsets.only(left:Dimenstions.width20),
                      child: bigText(text: 'Delivery address'),
                    ) ,
                    SizedBox(height: Dimenstions.height10,),
                    AppTextFeild(hintText: 'Your address', controller: _addressController, icon: Icons.map) ,
                    SizedBox(height: Dimenstions.height20,),
                    Padding(
                      padding:  EdgeInsets.only(left:Dimenstions.width20),
                      child: bigText(text: 'Contact name'),
                    ) ,
                    SizedBox(height: Dimenstions.height10,),
                    AppTextFeild(hintText: 'Your name', controller: _contactPersonNameController, icon: Icons.person),
                    SizedBox(height: Dimenstions.height20,),
                    Padding(
                      padding:  EdgeInsets.only(left:Dimenstions.width20),
                      child: bigText(text: 'Contact number'),
                    ) ,
                    SizedBox(height: Dimenstions.height10,),
                    AppTextFeild(hintText: 'Your number', controller: _contactPersonNumberController, icon: Icons.phone)
                  ],
                ),
              ) ;
            },
          ) ;
        },
      ) ,
        bottomNavigationBar: GetBuilder<LocationController>(
            builder: (controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: Dimenstions.height20*8,
                    padding: EdgeInsets.only(
                        top: Dimenstions.height30,
                        bottom: Dimenstions.height30,
                        right: Dimenstions.width20,
                        left: Dimenstions.width20),
                    decoration: BoxDecoration(
                        color: AppColors.buttonBackgroundColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(Dimenstions.radius20 * 2),
                            topLeft: Radius.circular(
                                Dimenstions.radius20 * 2))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (){
                            AddressModel _addressModel =AddressModel(
                                addressType: controller.addressTypeList[controller.addressTypeIndex] ,
                              contactPersonName: _contactPersonNameController.text ,
                              contactPersonNumber: _contactPersonNumberController.text ,
                              address: _addressController.text ,
                              latitude: controller.position.latitude.toString() ,
                              longitude: controller.position.longitude.toString()
                            );
                            controller.addAddress(_addressModel).then((response) {
                              if(response.isSuccess){
                                Get.toNamed(RouteHelper.getInitial());
                                Get.snackbar('Address', 'Added Successfully');
                              }else{
                                Get.snackbar('Address', 'Couldn\'t save Address');

                              }
                            });

                          },
                          child: Container(
                            padding: EdgeInsets.all(Dimenstions.height20),
                            child: bigText(
                                text: 'Save Address', color: Colors.white , size: 26),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimenstions.radius20),
                                color: AppColors.mainColor),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }
        )

    );
  }
}
