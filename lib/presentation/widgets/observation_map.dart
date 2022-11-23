import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_tile_caching/fmtc_advanced.dart';
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
        tileProvider: FMTC.instance[cleanTileStoreName(osmUrl)].getTileProvider(
          FMTCTileProviderSettings(
            behavior: CacheBehavior.cacheFirst,
            cachedValidDuration: const Duration(days: 28),
          ),
        ),
      ),
      TileLayer(
        urlTemplate: url,
        userAgentPackageName: 'app.fungid.flutter',
        retinaMode: MediaQuery.of(context).devicePixelRatio > 1.0,
        opacity: .6,
        backgroundColor: Colors.transparent,
        tileProvider: FMTC.instance[cleanTileStoreName(url)].getTileProvider(
          FMTCTileProviderSettings(
            behavior: CacheBehavior.cacheFirst,
            cachedValidDuration: const Duration(days: 7),
          ),
        ),
      ),
    ];

    if (showMarker) {
      layers.add(
        MarkerLayer(
          markers: [
            Marker(
              builder: (context) => const Icon(
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
        center: pos,
        zoom: 9.0,
        keepAlive: true,
        interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
      ),
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(
          source: '© OpenStreetMap',
          onSourceTapped: () {},
        ),
      ],
      children: layers,
    );
  }

  String cleanTileStoreName(String url) {
    return url.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_');
  }
}
