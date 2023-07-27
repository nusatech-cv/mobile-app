// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_google_map_polyline_point/flutter_polyline_point.dart';
import 'package:flutter_google_map_polyline_point/point_lat_lng.dart';
import 'package:flutter_google_map_polyline_point/utils/polyline_result.dart';
import 'package:flutter_google_map_polyline_point/utils/polyline_waypoint.dart';
import 'package:flutter_google_map_polyline_point/utils/request_enums.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pijetin/data/data.dart';
import 'package:pijetin/domain/controller/location_controller.dart';

import '../../config/config.dart';
import '../../utils/utils.dart';
import 'primary_button.dart';

class MapViewPage extends StatefulWidget {
  const MapViewPage({super.key, required this.point});
  final LatLng point;

  @override
  State<MapViewPage> createState() => _MapViewPageState();
}

class _MapViewPageState extends State<MapViewPage> {
  late GoogleMapController mapController;
  final LocationController locationController = Get.find();
  PolylinePoints polylinePoints = PolylinePoints();
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  String googleAPiKey = Environment.getApiKey()!;

  @override
  void initState() {
    _addMarker(
        LatLng(locationController.currentLocation.value.latitude,
            locationController.currentLocation.value.longitude),
        "origin",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(widget.point.latitude, widget.point.longitude),
        "destination", BitmapDescriptor.defaultMarkerWithHue(210));
    _getPolyline();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: WidgetHelper.appBar(
          title: "Location",
          onTap: () {
            Get.back();
          },
        ),
        body: GoogleMap(
          myLocationEnabled: true,
          tiltGesturesEnabled: true,
          compassEnabled: true,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          onMapCreated: _onMapCreated,
          markers: Set<Marker>.of(markers.values),
          polylines: Set<Polyline>.of(polylines.values),
          trafficEnabled: true,
          initialCameraPosition: CameraPosition(
              bearing: 0.0, target: widget.point, tilt: 0.0, zoom: 16),
        ),
        bottomNavigationBar: Container(
            padding: EdgeInsets.all(24.h),
            color: AppColor.background,
            child: PrimaryButton(
                title: "Close",
                onPressed: () {
                  Get.back();
                })),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
        width: 6,
        polylineId: id,
        color: Colors.blue,
        points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
        PointLatLng(locationController.currentLocation.value.latitude,
            locationController.currentLocation.value.longitude),
        PointLatLng(widget.point.latitude, widget.point.longitude),
        travelMode: TravelMode.walking,
        wayPoints: [PolylineWayPoint(location: "")]);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }
}
