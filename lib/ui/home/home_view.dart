import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber/datamodels/user_location.dart';

import 'widgets/bottom_sheet.dart';
import 'widgets/sidebar.dart';

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Builder(
            builder: (context) => Material(
              color: Colors.transparent,
              child: Ink(
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.dehaze),
                  color: Colors.black,
                  iconSize: 28,
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      drawer: UberSidebar(),
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
                UberBottomSheet(),
              ],
            )
          : Text(''),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            title: Text('Ride'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_dining),
            title: Text('Order food'),
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.black87,
        onTap: (_) {},
      ),
    );
  }
}
