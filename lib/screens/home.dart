// ignore_for_file: unused_local_variable, duplicate_ignore
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gallery/database/models.dart';
import 'package:gallery/database/functions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final DBAdapter adapter = HiveService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: FloatingActionButton(
                    onPressed: _pickImage,
                    tooltip: 'Increment',
                    child: const Icon(Icons.camera_alt_outlined),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ignore: duplicate_ignore
  Future<void> _pickImage() async {
    await GetPermissions();
    ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return;

    Uint8List imageBytes = await image.readAsBytes();
    setState(() {
      adapter.storeImage(imageBytes);
    });
    const folderName = "Fluttie";
    final path = Directory("storage/emulated/0/$folderName");
    if ((await path.exists())) {
      const Text('path exists');
    } else {
      path.create();
    }
    final String dirpath = (await getApplicationDocumentsDirectory()).path;

    // ignore: unused_local_variable
    File convertedImg = File(image.path);

    const fluttiepath = "storage/emulated/0/Fluttie";

    final String fileName = DateTime.now().toString().trim();
    final File localImage = await convertedImg.copy('$fluttiepath/$fileName');
    // ignore: avoid_print
    print("Saved image under: $dirpath/$fileName");
  }
}

// ignore: non_constant_identifier_names
GetPermissions() async {
  await Permission.camera.request();
  await Permission.storage.request();
}
