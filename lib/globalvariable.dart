// String mapKey = 'AIzaSyD1km7LXJW4ElPPUDNDD3QHPnAyTSHbZiI';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:satco_app/datamodels/user.dart';

String mapKey = 'AIzaSyBeYgtDKBfiCiUbI1DYNEMDc4TOTJBNf5A';

final CameraPosition googlePlex = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);

FirebaseUser currentFirebaseUser;

User currentUserInfo;