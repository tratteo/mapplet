import "dart:math";

import "package:flutter_map/flutter_map.dart";
import "package:geolocator/geolocator.dart";
import "package:latlong2/latlong.dart";
import "package:meta/meta.dart";

extension DbHashExtensions on String {
  @internal
  int toIsarHash() {
    var hash = 0xcbf29ce484222325;

    var i = 0;
    while (i < length) {
      final codeUnit = codeUnitAt(i++);
      hash ^= codeUnit >> 8;
      hash *= 0x100000001b3;
      hash ^= codeUnit & 0xFF;
      hash *= 0x100000001b3;
    }

    return hash;
  }
}

extension LatLngBoundsExtensions on LatLngBounds {
  /// Get the coordinates for the current [LatLngBounds] at the provided zoom levels
  List<TileCoordinates> coords(
    int minZoom,
    int maxZoom, {
    num tileSize = 256,
    Crs? crs,
  }) {
    final effectiveCrs = crs ?? const Epsg3857();
    final List<TileCoordinates> coordinates = [];

    for (int zoom = minZoom; zoom <= maxZoom; zoom++) {
      // Get the bounds in pixel coordinates at this zoom level

      final scaleLvl = effectiveCrs.scale(zoom.toDouble());
      final nw = effectiveCrs.latLngToXY(northWest, scaleLvl);
      final nwX = (nw.$1 / tileSize).floor();
      final nwY = (nw.$2 / tileSize).floor();

      final se = effectiveCrs.latLngToXY(southEast, scaleLvl);
      final seX = (se.$1 / tileSize).ceil() - 1;
      final seY = (se.$2 / tileSize).ceil() - 1;

      // Generate all tile coordinates within the bounds
      for (int x = nwX; x <= seX; x++) {
        for (int y = nwY; y <= seY; y++) {
          coordinates.add(TileCoordinates(x, y, zoom));
        }
      }
    }

    return coordinates;
  }

  /// Create a [LatLngBounds] specifying its center and the distance from center
  ///
  /// The result is a square region with half size equal to [deltaKm]
  static LatLngBounds fromDelta(LatLng center, double deltaKm) {
    // Earth's radius in kilometers
    const double earthRadiusKm = 6371;

    // Convert delta to radians
    final double deltaLat = (deltaKm / earthRadiusKm) * (180 / pi);

    // Adjust delta longitude based on latitude (accounts for Earth's curvature)
    final double deltaLng = (deltaKm / (earthRadiusKm * cos(center.latitude * pi / 180))) * (180 / pi);

    // Calculate bounds
    final double north = center.latitude + deltaLat;
    final double south = center.latitude - deltaLat;
    final double east = center.longitude + deltaLng;
    final double west = center.longitude - deltaLng;

    // Clamp latitude to valid range (-90, 90)
    final double clampedNorth = north.clamp(-90.0, 90.0);
    final double clampedSouth = south.clamp(-90.0, 90.0);

    return LatLngBounds(
      LatLng(clampedSouth, west),
      LatLng(clampedNorth, east),
    );
    // var nw = _getPointFromDelta(center, -deltaKm, deltaKm);
    // var ne = _getPointFromDelta(center, deltaKm, deltaKm);
    // var sw = _getPointFromDelta(center, -deltaKm, -deltaKm);
    // var se = _getPointFromDelta(center, deltaKm, -deltaKm);
    // return LatLngBounds.fromPoints([nw, ne, sw, se]);
  }
}

extension PositionExtensions on Position {
  LatLng toLatLng() => LatLng(latitude, longitude);
}

extension IntExtensions on int {
  double byteToMib() => this / 1048576;
  int mibToByte() => this * 1048576;
}

extension LatLngExtensions on LatLng {
  /// Returns the distance in meters
  double metersFrom(LatLng other) {
    const earthRadius = 6378137.0;
    var toRad = pi / 180;
    var dLat = (latitude - other.latitude) * toRad;
    var dLon = (longitude - other.longitude) * toRad;
    var sLat = sin(dLat / 2);
    var sLon = sin(dLon / 2);
    var a = sLat * sLat + sLon * sLon * cos(other.latitude * toRad) * cos(latitude * toRad);
    var c = 2 * asin(sqrt(a));
    return c * earthRadius;
  }
}

extension ListLatLngExtensions on List<LatLng> {
  /// Returns the center of mass of the list of points
  LatLng center() {
    double lat = 0;
    double lng = 0;
    for (final point in this) {
      lat += point.latitude;
      lng += point.longitude;
    }
    return LatLng(lat / length, lng / length);
  }

  /// Returns the maximum distance in kilometers between any two points
  double maxDistanceKm() {
    double dist = 0;
    for (final first in this) {
      for (final second in this) {
        var current = first.metersFrom(second) / 1000;
        if (current > dist) {
          dist = current;
        }
      }
    }
    return dist;
  }
}
