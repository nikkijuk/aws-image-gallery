import 'dart:async';

import 'package:aws_image_gallery/services/analytics_events.dart';
import 'package:aws_image_gallery/services/analytics_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {

  GalleryPage(
      {Key key,
        this.imageUrlsController,
        this.shouldLogOut,
        this.shouldShowCamera})
  : super(key: key) {
    AnalyticsService.log(ViewGalleryEvent());
  }

  final StreamController<List<String>> imageUrlsController;
  final VoidCallback shouldLogOut;
  final VoidCallback shouldShowCamera;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        actions: [
          // Log Out Button
          Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
                child: const Icon(Icons.logout),
                onTap: shouldLogOut,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.camera_alt),
          onPressed: shouldShowCamera,
      ),
      body: Container(child: _galleryGrid()),
    );
  }

  Widget _galleryGrid() {
    return StreamBuilder(
        stream: imageUrlsController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length != 0) {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      imageUrl: snapshot.data[index],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator()),
                    );
                  });
            } else {
              return const Center(child: Text('No images to display.'));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}