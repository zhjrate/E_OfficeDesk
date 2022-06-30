import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:soleoserp/blocs/other/bloc_modules/google_map/google_map_bloc.dart';
import 'package:soleoserp/models/api_requests/distance_matrix_api_request.dart';
import 'package:soleoserp/models/api_requests/google_place_api_request.dart';
import 'package:soleoserp/models/api_responses/company_details_response.dart';
import 'package:soleoserp/models/api_responses/google_place_search_response.dart';
import 'package:soleoserp/models/api_responses/login_user_details_api_response.dart';
import 'package:soleoserp/ui/res/color_resources.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/google_map_distance/search_destination_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/Modules/google_map_distance/search_source_screen.dart';
import 'package:soleoserp/ui/screens/DashBoard/home_screen.dart';
import 'package:soleoserp/ui/screens/base/base_screen.dart';
import 'package:soleoserp/ui/widgets/common_widgets.dart';
import 'package:soleoserp/utils/general_utils.dart';
import 'package:soleoserp/utils/shared_pref_helper.dart';

class MapScreen extends BaseStatefulWidget {
  static const routeName = '/MapScreen';

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends BaseState<MapScreen>
    with BasicScreen, WidgetsBindingObserver {
  // const kGoogleApiKey = “TOUR_API_KEY”;

  var _controller = TextEditingController();

  String _sessionToken;
  List<dynamic> _placeList = [];
  GoogleMapScreenBloc _googleMapScreenBloc;
  CompanyDetailsResponse _offlineCompanyData;
  LoginUserDetialsResponse _offlineLoggedInData;
  int CompanyID = 0;
  String LoginUserID = "";

  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  GoogleMapController mapController;
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData currentLocation;

  String Latitude;
  String Longitude;

  Position _currentPosition;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

// Starting point latitude
  double _originLatitude = 6.5212402;

// Starting point longitude
  double _originLongitude = 3.3679965;

// Destination latitude
  double _destLatitude = 6.849660;

// Destination Longitude
  double _destLongitude = 3.648190;

// Markers to show points on the map
  Map<MarkerId, Marker> markers = {};
  List<Marker> allMarkers = [];
  SearchGoogleResultResults _searchDetails;
  SearchGoogleResultResults _searchDetailsDestination;
  Set<Polyline> _polylines = {};

// this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];

// this is the key object - the PolylinePoints
// which generates every polyline between start and finish
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPIKey = "";

  String DistanceInMeter = "";
  String DistanceDuration = "";

  String MapAPIKey = "";

  @override
  void initState() {
    super.initState();
    screenStatusBarColor = colorPrimary;
    _offlineLoggedInData = SharedPrefHelper.instance.getLoginUserData();
    _offlineCompanyData = SharedPrefHelper.instance.getCompanyData();
    CompanyID = _offlineCompanyData.details[0].pkId;
    LoginUserID = _offlineLoggedInData.details[0].userID;
    _googleMapScreenBloc = GoogleMapScreenBloc(baseBloc);
    locationimplimentation();
    saveDetails();
    _getCurrentLocation();
    MapAPIKey = _offlineCompanyData.details[0].MapApiKey;
    print("MapAPIKey" + "Key : " + _offlineCompanyData.details[0].MapApiKey);
  }

  _getCurrentLocation() {
    geolocator.getCurrentPosition().then((Position position) {
      setState(() {
        _currentPosition = position;
        //  CreateMarkers(_currentPosition);
      });
      //_getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => _googleMapScreenBloc,
      child: BlocConsumer<GoogleMapScreenBloc, GoogleMapScreenStates>(
        builder: (BuildContext context, GoogleMapScreenStates state) {
          return super.build(context);
        },
        buildWhen: (oldState, currentState) {
          return false;
        },
        listener: (BuildContext context, GoogleMapScreenStates state) {
          if (state is DistanceMatrixState) {
            getDistanceBetweenLocations(state);
          }
          return super.build(context);
        },
        listenWhen: (oldState, currentState) {
          if (currentState is DistanceMatrixState) {
            return true;
          }
          return false;
        },
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: NewGradientAppBar(
          title: Text('Map Distance'),
          gradient:
              LinearGradient(colors: [Colors.blue, Colors.purple, Colors.red]),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.water_damage_sharp,
                  color: colorWhite,
                ),
                onPressed: () {
                  //_onTapOfLogOut();
                  navigateTo(context, HomeScreen.routeName,
                      clearAllStack: true);
                })
          ],
        ),
        body: Column(children: [
          SizedBox(
            height: 10,
          ),
          _buildSearchView(),
          SizedBox(
            height: 10,
          ),
          _buildSearchViewDestination(),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 400,
            child: GoogleMap(
              gestureRecognizers: Set()
                ..add(Factory<OneSequenceGestureRecognizer>(
                    () => new EagerGestureRecognizer()))
                ..add(
                    Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                ..add(Factory<ScaleGestureRecognizer>(
                    () => ScaleGestureRecognizer()))
                ..add(
                    Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
                ..add(Factory<VerticalDragGestureRecognizer>(
                    () => VerticalDragGestureRecognizer())),
              markers: Set<Marker>.from(allMarkers),
              buildingsEnabled: true,
              initialCameraPosition: _initialLocation,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              minMaxZoomPreference: MinMaxZoomPreference.unbounded,
              polylines: _polylines,
              // polylines: Set<Polyline>.of(polylines.values),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text("Distance : " +
              DistanceInMeter +
              "\n Duration : " +
              DistanceDuration),
        ]),
        drawer: build_Drawer(
            context: context,
            UserName: "KISHAN",
            RolCode: LoginUserID.toString()),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, HomeScreen.routeName, clearAllStack: true);
  }

/*
  _getAddress() async {
    try {
      // Places are retrieved using the coordinates
      List<Placemark> p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      // Taking the most probable result
      Placemark place = p[0];

      setState(() {

        // Structuring the address
        _currentAddress =
        "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";

        // Update the text of the TextField
        startAddressController.text = _currentAddress;

        // Setting the user's present location as the starting address
        _startAddress = _currentAddress;



      });
    } catch (e) {
      print(e);
    }

    startPlacemark = await locationFromAddress(_startAddress);
    destinationPlacemark = await locationFromAddress(_destinationAddress);
    startLatitude = startPlacemark[0].latitude;
    startLongitude = startPlacemark[0].longitude;
    destinationLatitude = destinationPlacemark[0].latitude;
    destinationLongitude = destinationPlacemark[0].longitude;
    startCoordinatesString=   '($startLatitude, $startLongitude)';
    destinationCoordinatesString =  '($destinationLatitude, $destinationLongitude)';
    Marker startMarker = Marker(
      markerId: MarkerId(startCoordinatesString),
      position: LatLng(startLatitude, startLongitude),
      infoWindow: InfoWindow(
        title: 'Start $startCoordinatesString',
        snippet: _startAddress,
      ),
      icon: BitmapDescriptor.defaultMarker,
    );

// Destination Location Marker
    Marker destinationMarker = Marker(
      markerId: MarkerId(destinationCoordinatesString),
      position: LatLng(destinationLatitude, destinationLongitude),
      infoWindow: InfoWindow(
        title: 'Destination $destinationCoordinatesString',
        snippet: _destinationAddress,
      ),
      icon: BitmapDescriptor.defaultMarker,
    );

    markers.add(startMarker);
    markers.add(destinationMarker);




  }
*/

/*
  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);

      print(lat);
      print(lng);
    }
  }
*/

  locationimplimentation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    currentLocation = await location.getLocation();
    setState(() {});
  }

  void saveDetails() async {
    location.onLocationChanged.listen((LocationData currentLocation) async {
      // Use current location
      print("OnLocationChange" +
          " Location : " +
          currentLocation.latitude.toString());
      //  placemarks = await placemarkFromCoordinates(currentLocation.latitude,currentLocation.longitude);
      // final coordinates = new Coordinates(currentLocation.latitude,currentLocation.longitude);
      // var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      // var first = addresses.first;
      //  print("${first.featureName} : ${first.addressLine}");
      Latitude = currentLocation.latitude.toString();
      Longitude = currentLocation.longitude.toString();
      _initialLocation = CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude));
      //  Address = "${first.featureName} : ${first.addressLine}";
    });
    //List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
  }

  CreateMarkers(Position currentPosition) {
    Marker startMarker = Marker(
      markerId: MarkerId("startCoordinatesString"),
      position: LatLng(currentPosition.latitude, currentPosition.longitude),
      infoWindow: InfoWindow(
        title: 'Start Point',
        snippet: "_startAddress",
      ),
      icon: BitmapDescriptor.defaultMarker,
    );

// Destination Location Marker
    Marker destinationMarker = Marker(
      markerId: MarkerId("destinationCoordinatesString"),
      position: LatLng(21.170240, 72.831062),
      infoWindow: InfoWindow(
        title: 'Destination Point',
        snippet: "_destinationAddress",
      ),
      icon: BitmapDescriptor.defaultMarker,
    );

    allMarkers.add(startMarker);
    allMarkers.add(destinationMarker);
  }

  Widget _buildSearchView() {
    return InkWell(
      onTap: () {
        _onTapOfSearchView();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 20),
            child: Text("Source",
                style: TextStyle(
                    fontSize: 12,
                    color: colorPrimary,
                    fontWeight: FontWeight
                        .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                ),
          ),
          SizedBox(
            height: 5,
          ),
          Card(
            elevation: 5,
            color: Color(0xffE0E0E0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: 60,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _searchDetails == null
                          ? "Tap to search Source"
                          : _searchDetails.formattedAddress,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: _searchDetails == null
                              ? colorGrayDark
                              : colorBlack),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: colorGrayDark,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSearchViewDestination() {
    return InkWell(
      onTap: () {
        _onTapOfSearchViewDestination();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 10, right: 20),
            child: Text("Destination",
                style: TextStyle(
                    fontSize: 12,
                    color: colorPrimary,
                    fontWeight: FontWeight
                        .bold) // baseTheme.textTheme.headline2.copyWith(color: colorBlack),

                ),
          ),
          SizedBox(
            height: 5,
          ),
          Card(
            elevation: 5,
            color: Color(0xffE0E0E0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: 60,
              padding: EdgeInsets.only(left: 20, right: 20),
              width: double.maxFinite,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _searchDetailsDestination == null
                          ? "Tap to search Destination"
                          : _searchDetailsDestination.formattedAddress,
                      style: baseTheme.textTheme.headline3.copyWith(
                          color: _searchDetailsDestination == null
                              ? colorGrayDark
                              : colorBlack),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: colorGrayDark,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _onTapOfSearchView() async {
    allMarkers.clear();
    navigateTo(context, SearchSourceScreen.routeName).then((value) {
      if (value != null) {
        _searchDetails = value;
        print("source:" + _searchDetails.geometry.location.lat.toString());
        _googleMapScreenBloc.add(PlaceSearchRequestCallEvent(
            MapAPIKey, PlaceSearchRequest(query: "")));
      }
      Marker destinationMarker = Marker(
        markerId: MarkerId("Source123"),
        position: LatLng(_searchDetails.geometry.location.lat,
            _searchDetails.geometry.location.lng),
        infoWindow: InfoWindow(
          title: 'Destination Point',
          snippet: "_destinationAddress",
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      allMarkers.add(destinationMarker);
    });
  }

  Future<void> _onTapOfSearchViewDestination() async {
    navigateTo(context, SearchDestinationScreen.routeName).then((value) {
      if (value != null) {
        _searchDetailsDestination = value;
        print("Destination:" +
            _searchDetailsDestination.geometry.location.lat.toString());
        /*_googleMapScreenBloc
            .add(PlaceSearchRequestCallEvent(PlaceSearchRequest(query: "")));
*/
        // print("DataRetrivefromValueTap:" + _searchDetailsDestination.name);
        _googleMapScreenBloc.add(DistanceMatrixCallEvent(
            MapAPIKey,
            DistanceMatrix_Request(
                origins: _searchDetails.geometry.location.lat.toString() +
                    "," +
                    _searchDetails.geometry.location.lng.toString(),
                destinations:
                    _searchDetailsDestination.geometry.location.lat.toString() +
                        "," +
                        _searchDetailsDestination.geometry.location.lng
                            .toString())));
      }
      Marker destinationMarker = Marker(
        markerId: MarkerId("destination123"),
        position: LatLng(_searchDetailsDestination.geometry.location.lat,
            _searchDetailsDestination.geometry.location.lng),
        infoWindow: InfoWindow(
          title: 'Destination Point',
          snippet: "_destinationAddress",
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      allMarkers.add(destinationMarker);

      setPolylines();
    });
  }

  setPolylines() async {
    _polylines.clear();
    polylineCoordinates.clear();

    PolylinePoints polylinePoints = PolylinePoints();
    PointLatLng origin = PointLatLng(_searchDetails.geometry.location.lat,
        _searchDetails.geometry.location.lng);
    PointLatLng destination = PointLatLng(
        _searchDetailsDestination.geometry.location.lat,
        _searchDetailsDestination.geometry.location.lng);

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "", origin, destination);

    print(result.points);

    List<PointLatLng> result123 = result.points;
    if (result123.isNotEmpty) {
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      result123.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    setState(() {
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
          polylineId: PolylineId("poly123"),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates);

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      _polylines.add(polyline);
    });
    double distanceInMeters = await Geolocator().distanceBetween(
      origin.latitude,
      origin.longitude,
      destination.latitude,
      destination.longitude,
    );
    // DistanceInMeter = distanceInMeters.toString();

    //
  }

  void getDistanceBetweenLocations(DistanceMatrixState state) {
    for (var i = 0; i < state.distanceMatrixResponse.rows.length; i++) {
      /*DistanceInMeter = state.distanceMatrixResponse.rows[i].elements[0].distance.text;
        DistanceDuration = state.distanceMatrixResponse.rows[i].elements[0].duration.text;
        print("MapDistance : " + state.distanceMatrixResponse.rows[i].elements[0].distance.text.toString());*/
      for (var j = 0;
          j < state.distanceMatrixResponse.rows[i].elements.length;
          j++) {
        DistanceInMeter =
            state.distanceMatrixResponse.rows[i].elements[j].distance.text;
        DistanceDuration =
            state.distanceMatrixResponse.rows[i].elements[j].duration.text;
        print("MapDistance : " +
            state.distanceMatrixResponse.rows[i].elements[j].distance.text
                .toString());
      }
    }

    setState(() {});
  }

/*
  getDistanceBetweenPoints(lat1, lng1, lat2, lng2){
    // The radius of the planet earth in meters
    double R = 6378137;
    double dLat = degreesToRadians(lat2 - lat1);
    double dLong = degreesToRadians(lng2 - lng1);
    double a = Math.sin(dLat / 2)
        *
        Math.sin(dLat / 2)
        +
        Math.cos(degreesToRadians(lat1))
            *
            Math.cos(degreesToRadians(lat1))
            *
            Math.sin(dLong / 2)
            *
            Math.sin(dLong / 2);

    double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    double distance = R * c;

    return distance;
  }
  degreesToRadians(degrees){
    return degrees * Math.PI / 180;
  }*/

}
