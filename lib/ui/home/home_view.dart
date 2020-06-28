import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber/datamodels/user_location.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);

    var cameraPosition = userLocation != null
        ? CameraPosition(
            target: LatLng(userLocation.latitude, userLocation.longitude),
          )
        : null;
    return Scaffold(
      body: cameraPosition != null
          ? GoogleMap(
              initialCameraPosition: cameraPosition,
            )
          : Text(""),
    );
  }
}
