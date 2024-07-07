import 'dart:io';

import 'package:favourite_places/models/location_modal.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlacesModal {
  final String id;
  final String placeName;
  final File image;
  final PlaceLocationModal placeLocation;

  PlacesModal({
    required this.placeName,
    required this.image,
    required this.placeLocation,
    id,
  }) : id = id ?? uuid.v4();
}
