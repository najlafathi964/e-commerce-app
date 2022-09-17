import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:food_delivary_app/controllers/location_controller.dart';
import 'package:food_delivary_app/shared/dimenstion.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/src/places.dart';

class SearchLocationDialogue extends StatelessWidget {
  final GoogleMapController mapController;

  const SearchLocationDialogue({Key? key, required this.mapController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();
    return Container(
      padding: EdgeInsets.all(Dimenstions.width10),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimenstions.radius20 / 2)),
        child: SizedBox(
          width: Dimenstions.screenWidth,
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                    hintText: 'search location',
                    hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                        color: Theme.of(context).disabledColor,
                        fontSize: Dimenstions.font16),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(style: BorderStyle.none, width: 0)))),
            itemBuilder: (BuildContext context, Prediction suggestion) {
              return Padding(
                padding: EdgeInsets.all(Dimenstions.width10),
                child: Row(
                  children: [
                    Icon(Icons.location_on),
                    Expanded(
                        child: Text(
                      suggestion.description!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                          color: Theme.of(context).textTheme.bodyText1?.color,
                          fontSize: Dimenstions.font16),
                    ))
                  ],
                ),
              );
            },
            onSuggestionSelected: (Prediction suggestion) {
              Get.find<LocationController>().setLocation(
                  suggestion.placeId!, suggestion.description!, mapController);
              Get.back();
            },
            suggestionsCallback: (pattern) async {
              return await Get.find<LocationController>()
                  .searchLocation(context, pattern);
            },
          ),
        ),
      ),
    );
  }
}
