import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraPicCaptureScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CameraPicCaptureScreenState();
  }
}

class CameraPicCaptureScreenState extends State<CameraPicCaptureScreen> {
  var cameras;
  var firstCamera;

  CameraController _controller;
  bool isCamerainitialized = false;

  @override
  void initState() {
    _initCamera();
    super.initState();
  }

  _initCamera() async {
    cameras = await availableCameras().then((onValue) {
      firstCamera = onValue.first;
      _controller = CameraController(firstCamera, ResolutionPreset.medium);
      _controller.initialize().then((onValue) {
        setState(() {
          isCamerainitialized = true;
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints.expand(),
          child: isCamerainitialized ? CameraPreview(_controller) : Text("Initializing camera..")
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        splashColor: Colors.white,
        elevation: 6,
        onPressed: () async {
          try {
            final path = join(
              (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );
            await _controller.takePicture(path).then((onValue) {
              Navigator.pop(context, path);
            });
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}