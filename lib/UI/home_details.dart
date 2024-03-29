import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:mapbox_gl/mapbox_gl.dart';
//import 'package:epaisa/blocs/login_provider.dart';

import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

const kGoogleApiKey = "AIzaSyB2WBBSCy1Le4RK9tDMNt-lQa917J7G0Lg";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class HomeDetails extends StatefulWidget {
  HomeDetails({Key key}) : super(key: key);

  @override
  _HomeDetailsState createState() => new _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails>
    with SingleTickerProviderStateMixin {
  final FocusNode _searchFocusNodeLocation = FocusNode();
  Mode _mode = Mode.overlay;
  MapboxMapController mapBoxController;

  //Set initial LAT & LNG
  static double lat = 19.0760;
  static double lng = 72.8777;

  //Creating map controller method
  void _onMapCreated(MapboxMapController controller) {
    mapBoxController = controller;
  }

  final homeScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  @override
  void dispose() {
    _searchFocusNodeLocation.dispose();
    super.dispose();
  }

  //Get Device Geo Locations
  _getLocation() async {
    loc.LocationData currentLocation;
    loc.Location _locationService = new loc.Location();
    try {
      currentLocation = await _locationService.getLocation();
      setState(() {
        lat = currentLocation.latitude;
        lng = currentLocation.longitude;
      }); //rebuild the widget after getting the current location of the user
    } on Exception {
      currentLocation = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    //final bloc = LoginProvider.of(context);
    return Scaffold(
      key: homeScaffoldKey,
      body: Stack(
        children: <Widget>[
          MapboxMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition:
                CameraPosition(target: LatLng(lat, lng), zoom: 15.0),
          ),
          Positioned(
              top: 50.0,
              right: 15.0,
              left: 15.0,
              child: Material(
                elevation: 3.0,
                shadowColor: Colors.black,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: GestureDetector(
                    onTap: _handlePressButton,
                    child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        child: Text(
                          "Enter Destination",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ))),
              ))
        ],
      ),
    );
  }

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      mode: _mode,
    );

    displayPrediction(p, homeScaffoldKey.currentState);
  }

  Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;

      scaffold.showSnackBar(
        SnackBar(content: Text("${p.description} - $lat/$lng")),
      );
    }
  }
}
