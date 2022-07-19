import 'package:camera/camera.dart';

class CameraProvider {
  CameraProvider({required List<CameraDescription> cameras})
      : _cameras = cameras;

  final List<CameraDescription> _cameras;

  List<CameraDescription> getCameras() {
    return _cameras;
  }
}

class CameraRepository {
  CameraRepository(this.provider);

  final CameraProvider provider;

  List<CameraDescription> getAllCameras() {
    return provider.getCameras();
  }
}
