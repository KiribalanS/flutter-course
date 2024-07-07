import 'dart:io';

import 'package:favourite_places/models/location_modal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as spath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import 'package:favourite_places/models/places_modal.dart';

Future<Database> getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final Database db = await sql.openDatabase(
    path.join(dbPath, 'my_places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, latitude REAL, longitude REAL, address TEXT)');
    },
    version: 2,
  );
  return db;
}

class UserPlacesNotifier extends StateNotifier<List<PlacesModal>> {
  UserPlacesNotifier() : super([]);

  Future<void> loadPlaces() async {
    final db = await getDatabase();
    final allPlaces = await db.query('user_places');
    final List<PlacesModal> localList = allPlaces.map(
      (row) {
        return PlacesModal(
          image: File(row["image"] as String),
          placeName: row["title"] as String,
          placeLocation: PlaceLocationModal(
            latitude: row["latitude"] as double,
            address: row["title"] as String,
            longitude: row["longitude"] as double,
          ),
        );
      },
    ).toList();
    state = localList;
  }

  void addNewPlace(
      File image, String placeName, PlaceLocationModal placeLocation) async {
    final appDir = await spath.getApplicationDocumentsDirectory();

    final imgPath = path.basename(image.path);
    final newImg = await image.copy('${appDir.path}/$imgPath');
    PlacesModal newPlace = PlacesModal(
      placeName: placeName,
      image: newImg,
      placeLocation: placeLocation,
    );
    final db = await getDatabase();
    db.insert('user_places', {
      "id": newPlace.id,
      "title": newPlace.placeName,
      "image": newPlace.image.path,
      "latitude": newPlace.placeLocation.latitude,
      "longitude": newPlace.placeLocation.longitude,
      "address": newPlace.placeLocation.address,
    });
    state = [...state, newPlace];
  }
}

final userPlaces = StateNotifierProvider<UserPlacesNotifier, List<PlacesModal>>(
  (ref) => UserPlacesNotifier(),
);
