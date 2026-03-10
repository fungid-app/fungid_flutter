import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class ObservationMapView extends StatelessWidget {
  final Position position;
  final String url;
  final bool showMarker;

  ObservationMapView({
    Key? key,
    required this.position,
    required this.url,
    required this.showMarker,
  }) : super(key: key);
  final _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    String osmUrl = "https://tile.openstreetmap.org/{z}/{x}/{y}.png";

    LatLng pos = LatLng(position.latitude, position.longitude);

    List<Widget> layers = [
      TileLayer(
        urlTemplate: osmUrl,
        userAgentPackageName: 'app.fungid.flutter',
        retinaMode: MediaQuery.of(context).devicePixelRatio > 1.0,
        tileProvider: const FMTCStore('osm_tiles').getTileProvider(),
      ),
      Opacity(
        opacity: 0.6,
        child: TileLayer(
          urlTemplate: url,
          userAgentPackageName: 'app.fungid.flutter',
          retinaMode: MediaQuery.of(context).devicePixelRatio > 1.0,
          tileProvider: const FMTCStore('overlay_tiles').getTileProvider(),
        ),
      ),
    ];

    if (showMarker) {
      layers.add(
        MarkerLayer(
          markers: [
            Marker(
              child: const Icon(
                Icons.location_on,
                color: Colors.red,
              ),
              point: pos,
            ),
          ],
        ),
      );
    }

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: pos,
        initialZoom: 9.0,
        keepAlive: true,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
        ),
      ),
      children: [
        ...layers,
        const SimpleAttributionWidget(
          source: Text('© OpenStreetMap'),
        ),
      ],
    );
  }
}
