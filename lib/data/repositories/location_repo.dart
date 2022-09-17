import 'package:food_delivary_app/data/api/api_client.dart';
import 'package:food_delivary_app/models/address_model.dart';
import 'package:food_delivary_app/models/response_model.dart';
import 'package:food_delivary_app/shared/app_constants.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo {
  final ApiClient apiClient;

  final SharedPreferences sharedPreferences;

  LocationRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getAddressfromGeoCode(LatLng latLng) async {
    return await apiClient.getData('${AppConstants.GEOCODE_URI}'
        '?lat=${latLng.latitude}&lng=${latLng.longitude}');
  }

  String getUserAddress() {
    return sharedPreferences.getString(AppConstants.USER_ADDRESS) ?? '';
  }

  Future<Response> addAddress(AddressModel addressModel) async {
    return await apiClient.postData(
        AppConstants.ADD_USER_ADDRESS, addressModel.toJson());
  }

  Future<Response> getAllAddress() async {
    return await apiClient.getData(AppConstants.ADDRESS_LISt_URI);
  }

  Future<bool> saveUserAddress(String userAddress) async {
    apiClient.updateHeader(sharedPreferences.getString(AppConstants.TOKEN)!);
    return await sharedPreferences.setString(
        AppConstants.USER_ADDRESS, userAddress);
  }

  Future<Response> getZone(String lat, String lng) async {
    return await apiClient
        .getData('${AppConstants.ZONE_URI}?lat=$lat&lng=$lng');
  }

  Future<Response> searchLocation(String text) async {
    return await apiClient
        .getData('${AppConstants.SEARCH_LOCATION_URI}?search_text=$text');
  }

  Future<Response> setLocation(String placeId) async {
    return await apiClient
        .getData('${AppConstants.PLACE_DETAILS_URI}?place_id=$placeId');
  }
}
