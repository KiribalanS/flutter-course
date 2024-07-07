import 'package:favourite_places/models/location_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({
    super.key,
    this.placeLocation = const PlaceLocationModal(
      address: "",
      latitude: 37.422,
      longitude: -122.084,
    ),
    this.isSelection = true,
  });
  final PlaceLocationModal placeLocation;
  final bool isSelection;
  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final MapController mapController = MapController();

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  final List<Marker> markers = List.empty(growable: true);
  LatLng? latLng;
  @override
  void initState() {
    super.initState();
    final lat = widget.placeLocation.latitude;
    final lng = widget.placeLocation.longitude;
    latLng = LatLng(lat, lng);
    final initialMarker = Marker(
      width: 50.0,
      height: 50.0,
      point: latLng!,
      child: const Icon(
        Icons.location_on,
        size: 60.0,
        color: Colors.red,
      ),
    );

    markers.add(initialMarker);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tom tom maps"),
        actions: !widget.isSelection
            ? []
            : [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context, latLng);
                  },
                  icon: const Icon(Icons.save),
                ),
              ],
      ),
      body: FlutterMap(
        options: MapOptions(
          onTap: widget.isSelection
              ? (tapPosition, point) {
                  markers.clear();
                  setState(() {
                    latLng = point;
                    markers.add(
                      Marker(
                        point: point,
                        child: const Icon(
                          Icons.location_on,
                          size: 60.0,
                          color: Colors.red,
                        ),
                      ),
                    );
                  });
                }
              : null,
          initialCenter: latLng!,
          minZoom: 12,
          maxZoom: 14,
          initialZoom: 13,

          // cameraConstraint: CameraConstraint.containCenter(
          //   bounds: LatLngBounds(northEast, southWest),
          // ),
        ),
        mapController: mapController,
        children: [
          const Text("Map"),
          TileLayer(
            tileProvider: NetworkTileProvider(),
            maxZoom: 14,
            urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
                "{z}/{x}/{y}.png?key=YOUR_API_KEY_TOM_TOM",
          ),
          MarkerLayer(
            markers: markers,
          ),
        ],
      ),
    );
  }
}
