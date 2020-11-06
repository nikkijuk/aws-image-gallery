import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {

  GalleryPage({Key key, this.shouldLogOut, this.shouldShowCamera})
      : super(key: key);

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
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
        ),
        itemCount: 3,
        itemBuilder: (context, index) {
            return const Placeholder();
          },
        );
  }
}