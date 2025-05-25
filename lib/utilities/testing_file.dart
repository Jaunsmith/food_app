/*
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../controllers/delivery_address_controller.dart';

class LocationPickerScreen extends StatelessWidget {
  final LocationController locationController = Get.find();

  LocationPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Your Location'),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () => locationController.getCurrentLocation(),
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              final saved = await locationController.saveLocation();
              if (saved) {
                Get.back(result: locationController.selectedAddress.value);
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Obx(() {
            final address = locationController.selectedAddress.value;

            // Use fallback location if address is null
            final latLng =
                address != null
                    ? LatLng(address.latitude, address.longitude)
                    : const LatLng(0.0, 0.0);

            return FlutterMap(
              options: MapOptions(
                initialCenter:
                    latLng, // Changed from 'center' to 'initialCenter'
                initialZoom: 15.0, // Changed from 'zoom' to 'initialZoom'
                onTap: (tapPosition, tappedLatLng) {
                  // Updated onTap signature
                  locationController.updateSelectedPosition(tappedLatLng);
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.food_app',
                ),
                if (address != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(address.latitude, address.longitude),
                        child: const Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
              ],
            );
          }),
          // Search Bar + Results
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Column(
              children: [
                SearchBar(
                  onChanged:
                      (value) => locationController.searchLocation(value),
                  hintText: 'Search for a location...',
                ),
                Obx(() {
                  if (locationController.searchResults.isEmpty) {
                    return const SizedBox();
                  }
                  return Container(
                    margin: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: locationController.searchResults.length,
                      itemBuilder: (ctx, index) {
                        final result = locationController.searchResults[index];
                        return ListTile(
                          title: Text(result.displayName),
                          subtitle: Text(
                            '${result.street ?? ''}, ${result.city ?? ''}',
                            overflow: TextOverflow.ellipsis,
                          ),
                          onTap:
                              () =>
                                  locationController.selectSearchResult(result),
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
          // Info Card
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Obx(() {
              final address = locationController.selectedAddress.value;
              if (address == null) return const SizedBox();
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address.displayName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      if (address.street != null) Text(address.street!),
                      if (address.city != null)
                        Text(
                          '${address.city}, '
                          '${address.state ?? ''} '
                          '${address.postalCode ?? ''}',
                        ),
                      const SizedBox(height: 8),
                      Text(
                        'Lat: ${address.latitude.toStringAsFixed(4)}, '
                        'Lng: ${address.longitude.toStringAsFixed(4)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          // Loading Indicator
          Obx(
            () =>
                locationController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
*/
