import 'dart:convert';
import 'package:favourite_places/models/location_modal.dart';
import 'package:favourite_places/screens/maps_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import 'package:location/location.dart';

class PlaceLocationInput extends StatefulWidget {
  const PlaceLocationInput({
    required this.onPlaceLocationChanged,
    super.key,
  });
  final void Function(PlaceLocationModal location) onPlaceLocationChanged;
  @override
  State<StatefulWidget> createState() {
    return _PlaceLocationInputState();
  }
}

class _PlaceLocationInputState extends State<PlaceLocationInput> {
  bool isLoading = false;
  var lng;
  var lat;
  String _url = "";
  PlaceLocationModal? placeLocationModal;

  void saveAddress(latitude, longitude) async {
    final url = Uri.parse(
        "https://api.tomtom.com/search/2/reverseGeocode/$latitude,$longitude.json?key=YOUR_API_KEY_TOM_TOM");
    final placeLocationInfo = await http.get(url);

    Map<String, dynamic> response = json.decode(placeLocationInfo.body);

    final address = response["addresses"][0]["address"]["freeformAddress"];

    setState(() {
      placeLocationModal = PlaceLocationModal(
        latitude: latitude!,
        longitude: longitude!,
        address: address,
      );
      _url =
          "https://api.tomtom.com/map/1/staticimage?key=YOUR_API_KEY_TOM_TOM&zoom=9&center=$longitude,$latitude&format=jpg&layer=basic&style=main&width=650&height=500&language=en-US";
      isLoading = false;
    });
    if (placeLocationModal != null) {
      widget.onPlaceLocationChanged(placeLocationModal!);
      return;
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error while adding the location"),
        ),
      );
    }
    return;
  }

  void getUserCurrentLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;
    setState(() {
      isLoading = true;
    });
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        setState(() {
          isLoading = false;
        });
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        setState(() {
          isLoading = false;
        });
        return;
      }
    }
    locationData = await location.getLocation();
    if (locationData.longitude == null || locationData.latitude == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Select a location"),
          ),
        );
      }
      return;
    }
    saveAddress(locationData.latitude, locationData.longitude);
  }

  void getAddressFromMap() async {
    final result = await Navigator.push<LatLng>(
      context,
      MaterialPageRoute(
        builder: (context) => const MapsScreen(),
      ),
    );

    if (result == null) {
      return;
    }
    saveAddress(result.latitude, result.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.9,
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: _url == ""
                      ? const Text("Add location")
                      : Image.network(
                          fit: BoxFit.cover,
                          width: double.infinity,
                          _url,
                        ),
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: getUserCurrentLocation,
              icon: const Icon(Icons.map_rounded),
              label: const Text("Get current location"),
            ),
            TextButton.icon(
              onPressed: getAddressFromMap,
              icon: const Icon(Icons.map_rounded),
              label: const Text("Select on map"),
            ),
          ],
        ),
      ],
    );
  }
}
