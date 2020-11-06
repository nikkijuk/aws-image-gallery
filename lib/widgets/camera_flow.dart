import 'package:aws_image_gallery/pages/camera_page.dart';
import 'package:aws_image_gallery/pages/gallery_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraFlow extends StatefulWidget {
  CameraFlow({Key key, this.shouldLogOut}) : super(key: key);

  final VoidCallback shouldLogOut;

  @override
  State<StatefulWidget> createState() => _CameraFlowState();
}

class _CameraFlowState extends State<CameraFlow> {

  CameraDescription _camera;
  bool _shouldShowCamera = false;

  List<MaterialPage> get _pages {
    return [
      // Show Gallery Page
      MaterialPage(
          child: GalleryPage(
              shouldLogOut: widget.shouldLogOut,
              shouldShowCamera: () => _toggleCameraOpen(true),
          ),
      ),

      // Show Camera Page
      if (_shouldShowCamera)
        MaterialPage(
          child: CameraPage(
              camera: _camera,
              didProvideImagePath: (imagePath) {
                  _toggleCameraOpen(false);
              },
          ),
        )
    ];
  }

  @override
  void initState() {
    super.initState();
    _getCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: _pages,
      onPopPage: (route, result) => route.didPop(result),
    );
  }

  void _toggleCameraOpen(bool isOpen) {
    setState(() {
      _shouldShowCamera = isOpen;
    });
  }

  void _getCamera() async {
    final camerasList = await availableCameras();
    setState(() {
      final firstCamera = camerasList.first;
      _camera = firstCamera;
    });
  }

}