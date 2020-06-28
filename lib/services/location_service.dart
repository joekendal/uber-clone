import 'dart:async';

import 'package:location/location.dart';
import 'package:uber/datamodels/user_location.dart';

class LocationService {
  // keep track of current location
  UserLocation _currentLocation;

  Location location = Location();

  // continuosly emit location data
  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  LocationService() {
    location.requestPermission().then((granted) {
      if (granted == PermissionStatus.granted) {
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            _locationController.add(UserLocation(
              longitude: locationData.longitude,
              latitude: locationData.latitude,
            ));
          }
        });
      }
    });
  }

  Stream<UserLocation> get locationStream => _locationController.stream;

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
          latitude: userLocation.latitude, longitude: userLocation.longitude);
    } catch (e) {
      print('Could not get the location');
    }
    return _currentLocation;
  }
}
