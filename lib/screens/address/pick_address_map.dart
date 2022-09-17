import 'package:flutter/material.dart';
import 'package:food_delivary_app/helper/route_helper.dart';
import 'package:food_delivary_app/screens/address/search_location_dialogue.dart';
import 'package:food_delivary_app/shared/app_colors.dart';
import 'package:food_delivary_app/shared/componants.dart';
import 'package:food_delivary_app/shared/dimenstion.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controllers/location_controller.dart';
import 'package:get/get.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress ;
  final GoogleMapController? googleMapController ;
  const PickAddressMap({Key? key , required this.fromSignup , required this.fromAddress , this.googleMapController}) : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition ;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition ;

  @override
  void initState(){
    super.initState();
    if(Get.find<LocationController>().addressList.isEmpty){
      _initialPosition = LatLng(45.521563, -122.677433);
      _cameraPosition = CameraPosition(target: _initialPosition , zoom: 17);
    }else{
      if(Get.find<LocationController>().addressList.isNotEmpty){
        _initialPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress['latitude']),
            double.parse(Get.find<LocationController>().getAddress['longitude']));
        _cameraPosition = CameraPosition(target: _initialPosition , zoom: 17);      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController){
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  GoogleMap(initialCameraPosition: CameraPosition(
                      target: _initialPosition ,
                      zoom: 17
                  ),
                    zoomControlsEnabled: false,
                    onCameraMove: (CameraPosition cameraPosition){
                      _cameraPosition=cameraPosition;
                    },
                    onCameraIdle: (){
                      Get.find<LocationController>().updatePosition(_cameraPosition, false);
                    },
                    onMapCreated: (GoogleMapController mapController){
                    _mapController = mapController ;
                    if(!widget.fromAddress){

                    }
                    },
                  ) ,
                  Center(
                    child: !locationController.loading?Icon(Icons.location_pin , size: 50,color: AppColors.mainColor,)      //Image.asset('assets/images/marker.png' , height: 50 , width: 50,)
                    :CircularProgressIndicator(),
                  ) ,
                  Positioned(
                    top: Dimenstions.height45,
                      left: Dimenstions.width20,
                      right: Dimenstions.width20,
                      child: InkWell(
                        onTap: ()=> Get.dialog(SearchLocationDialogue(mapController: _mapController)),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimenstions.width10),
                          height: 50 ,
                            decoration: BoxDecoration(
                              color: AppColors.mainColor ,
                              borderRadius: BorderRadius.circular(Dimenstions.radius20/2),
                            ),
                          child: Row(
                            children: [
                              Icon(Icons.location_on , size: 25 ,color: AppColors.yellowColor,) ,
                              Expanded(
                                  child: Text(
                                  '${locationController.pickPlacemark.name??''}',
                                    style: TextStyle(
                                      color: Colors.white ,
                                      fontSize: Dimenstions.font16
                                    ),
                                    maxLines: 1 ,
                                      overflow: TextOverflow.ellipsis,
                                  )) ,
                              SizedBox(width: Dimenstions.width10) ,
                              Icon(Icons.search , color: AppColors.yellowColor)
                            ],
                          ),
                        ),
                      )) ,
                  Positioned(
                    bottom: 80,
                      left: Dimenstions.width20,
                      right: Dimenstions.width20,
                      child: locationController.isLoading ? Center(child: CircularProgressIndicator(),)
                          :CustomButton(
                          context: context,
                          width: 200,
                          buttonText: locationController.inZone ? widget.fromAddress?'Pick Address' : 'Pcl Location' : 'Service is not available in your area',
                          onPressed:(locationController.buttonDisable || locationController.loading) ? null : (){
                            if(locationController.pickPosition.latitude != 0 && locationController.pickPlacemark.name != null){
                              if(widget.fromAddress){
                                if(widget.googleMapController!=null){
                                  widget.googleMapController!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
                                      target: LatLng(locationController.pickPosition.latitude , locationController.pickPosition.longitude)
                                  )));
                                  locationController.setAddAddressData();

                                }
                                Get.toNamed(RouteHelper.getAddAddressPage());
                              }
                            }
                          }
                      )
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
