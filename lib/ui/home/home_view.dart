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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(2.0),
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
                  iconSize: 30,
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer header'),
            ),
            ListTile(
              title: Text('item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
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
                    initialChildSize: 0.379,
                    minChildSize: 0.2,
                    maxChildSize: 0.379,
                    builder: (context, scrollController) {
                      return NotificationListener<
                          OverscrollIndicatorNotification>(
                        onNotification: (overscroll) {
                          overscroll.disallowGlow();
                          return true;
                        },
                        child: SingleChildScrollView(
                          controller: scrollController,
                          physics: ClampingScrollPhysics(),
                          child: Container(
                            color: Colors.white,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.grey[300],
                                          ),
                                          height: 5,
                                          width: 40,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          height: 52.5,
                                          color: Colors.grey[200],
                                          child: Padding(
                                            padding: const EdgeInsets.all(14),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Where to?',
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 52.5,
                                          color: Colors.grey[200],
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(right: 14.0),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Chip(
                                                avatar: Icon(
                                                  Icons.watch_later,
                                                  color: Colors.black87,
                                                ),
                                                backgroundColor: Colors.white,
                                                label: RichText(
                                                  text: TextSpan(
                                                    children: <InlineSpan>[
                                                      TextSpan(
                                                        text: 'Now',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      WidgetSpan(
                                                        child: SizedBox(
                                                            width: 2.5),
                                                      ),
                                                      WidgetSpan(
                                                        alignment:
                                                            PlaceholderAlignment
                                                                .middle,
                                                        child: Icon(Icons
                                                            .keyboard_arrow_down),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                RecommendedTrip(
                                    postcode: 'AB65 7UQ',
                                    addressLine1: 'Design District'),
                                Divider(),
                                RecommendedTrip(
                                    postcode: 'YF82 2LO',
                                    addressLine1: 'Flutter Avenue'),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
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

class RecommendedTrip extends StatelessWidget {
  final String postcode;
  final String addressLine1;
  const RecommendedTrip({
    Key key,
    String postcode,
    String addressLine1,
  })  : this.postcode = postcode,
        this.addressLine1 = addressLine1,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListTile(
        leading: Material(
          color: Colors.transparent,
          child: Ink(
            decoration: ShapeDecoration(
              color: Colors.grey[200],
              shape: CircleBorder(),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.location_on,
                size: 15,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              postcode,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              addressLine1,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 17,
          color: Colors.grey[400],
        ),
      ),
    );
  }
}
