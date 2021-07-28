import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapView extends StatefulWidget {
  late double longitude, latitude;
  String id;
  MapView({required this.latitude, required this.longitude, required this.id});

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final MapController _mapController = MapController();

  var interActiveFlags = InteractiveFlag.all;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LatLng currentLatLng;

    currentLatLng = LatLng(widget.latitude, widget.longitude);

    var markers = <Marker>[
      Marker(
        width: 40.0,
        height: 40.0,
        point: currentLatLng,
        builder: (ctx) => Container(
          child: FlutterLogo(
            textColor: Colors.blue,
            key: ObjectKey(Colors.blue),
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Map view')),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: currentLatLng,
          zoom: 5.0,
          interactiveFlags: interActiveFlags,
          // onMapCreated: (MapController controller) {
          //   // _mapController.move(currentLatLng, 16);
          //   // setState(() {});
          // },
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
            tileProvider: NonCachingNetworkTileProvider(),
          ),
          MarkerLayerOptions(markers: markers)
        ],
      ),
      floatingActionButton: Builder(builder: (BuildContext context) {
        return FloatingActionButton(
          onPressed: () {
            Map<String, dynamic> data = {
              "find": true,
              "latitude": currentLatLng.latitude,
              "longitude": currentLatLng.longitude,
            };
            FirebaseFirestore.instance
                .collection("Items")
                .doc(widget.id)
                .update(data)
                .then((value) {
              Navigator.pop(context);
            }).catchError((onError) {});
          },
          child: Icon(Icons.location_on),
        );
      }),
    );
  }
}
