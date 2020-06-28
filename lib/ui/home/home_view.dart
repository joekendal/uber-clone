import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber/datamodels/user_location.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation>(context);

    var cameraPosition = userLocation != null
        ? CameraPosition(
            target: LatLng(userLocation.latitude, userLocation.longitude),
            zoom: 14,
          )
        : null;
    return Scaffold(
      body: cameraPosition != null
          ? Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                GoogleMap(
                  initialCameraPosition: cameraPosition,
                  compassEnabled: false,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  buildingsEnabled: true,
                  myLocationButtonEnabled: false,
                  minMaxZoomPreference: MinMaxZoomPreference(12, 20),
                  mapToolbarEnabled: false,
                  rotateGesturesEnabled: false,
                ),
                DraggableScrollableSheet(
                    initialChildSize: 0.425,
                    minChildSize: 0.2,
                    maxChildSize: 0.425,
                    builder: (context, scrollController) {
                      return NotificationListener<
                          OverscrollIndicatorNotification>(
                        onNotification: (overscroll) {
                          overscroll.disallowGlow();
                          return true;
                        },
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Container(
                            color: Colors.white,
                            height: 400,
                          ),
                        ),
                      );
                    }),
              ],
            )
          : Text(''),
    );
  }
}
