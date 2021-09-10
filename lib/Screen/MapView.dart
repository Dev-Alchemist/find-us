import 'package:findus/Screen/Clim_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
// import 'package:location/location.dart';

class MapView extends StatefulWidget {
  // double longitude, latitude;
  final String id;
  final bool? check;
  MapView(
      {
      //required this.latitude,
      // required this.longitude,
      required this.id,
      this.check});

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  MapController? _mapController = MapController();

  var interActiveFlags = InteractiveFlag.all;
  Position? currentPos;
  bool click=false;

//  Location _locationService = Location();
//   bool _permission = false;
  @override
  void initState() {
    super.initState();
    if (widget.check!) {
      setCurrent();
      // initLocationService();
    }
  }


  setCurrent()   async {
  var value = await    getLocation();
   if (value ==null) {
        setCurrent();
      } else {
        print(value.latitude);
        currentPos = value;
        _mapController!
            .move(LatLng(currentPos!.latitude, currentPos!.longitude), 10);
click=true;
        setState(() {});
      }
  }

  Future<Position?> getLocation() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        print("Here");

        
        permission = await Geolocator.requestPermission();
        print("Here2");

        if (permission == LocationPermission.denied) {
        print("Here3");

          return null;
        }
      } else {
        print("Here");

        Position position = await GeolocatorPlatform.instance
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        return position;
      }
    } catch (ex) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // LatLng currentLatLng;

    // currentLatLng = LatLng(widget.latitude, widget.longitude);

    var markers = <Marker>[
      Marker(
        width: 40.0,
        height: 40.0,
        point:
        //  widget.check!
        //     ? 
            
            currentPos == null
                ? LatLng(40.416775, -3.703790)
                : LatLng(currentPos!.latitude, currentPos!.longitude),
            // : LatLng(widget.latitude, widget.longitude),
        builder: (ctx) => Container(
            child: Icon(
          Icons.location_pin,
          size: 35,
          color: Colors.orange,
        )),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Map view')),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: 
          
          // widget.check!
          //     ? 
              LatLng(40.416775, -3.703790),
              // : LatLng(widget.latitude, widget.longitude),
           
          zoom: 15.0,
          interactiveFlags: interActiveFlags,
          
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
      floatingActionButton: widget.check!
          ? Builder(builder: (BuildContext context) {
              return FloatingActionButton.extended(
                onPressed: click? () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>  Clim_Screen(
                            id: widget.id,
                            latitude: currentPos!.latitude,
                            longitude: currentPos!.longitude,
                          )));
                }:(){},
                icon: Icon(Icons.thumb_up),
                label: click?Text('Confirm'):CircularProgressIndicator(color: Colors.black) ,
                // child: Icon(Icons.location_on),
              );
            })
          : Container(),
    );
  }
}
