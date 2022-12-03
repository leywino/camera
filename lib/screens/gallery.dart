import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:gallery/database/models.dart';
import 'package:gallery/database/functions.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  final DBAdapter adapter = HiveService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Uint8List>?>(
        future: _readImagesFromDatabase(),
        builder: (context, AsyncSnapshot<List<Uint8List>?> snapshot) {
          if (snapshot.hasError) {
            return Text("Error appeared ${snapshot.error}");
          }

          if (snapshot.hasData) {
            if (snapshot.data == null) return const Text("Nothing to show");

            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 20,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => Image.memory(
                  snapshot.data![index],
                ),
              ),
            );
          }
          setState(() {
            if (snapshot.data != null) {}
          });
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<List<Uint8List>?> _readImagesFromDatabase() async {
    return adapter.getImages();
  }
}
