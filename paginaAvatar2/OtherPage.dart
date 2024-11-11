import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Other Page'),
      ),
      body: Center(
        child: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (BuildContext context,
              AsyncSnapshot<SharedPreferences> snapshot) {
            if (snapshot.hasData) {
              String selectedImageName =
                  snapshot.data!.getString('selectedImageName') ?? '';
              String selectedImageBytesString =
                  snapshot.data!.getString('selectedImageBytes') ?? '';
              if (selectedImageName.isNotEmpty &&
                  selectedImageBytesString.isNotEmpty) {
                Uint8List selectedImageBytes =
                    base64Decode(selectedImageBytesString);
                final image = MemoryImage(selectedImageBytes);
                return Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: image,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              } else {
                return const Text('No image selected');
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
