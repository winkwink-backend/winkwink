import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VisibleImageSelector extends StatefulWidget {
  const VisibleImageSelector({super.key});

  @override
  State<VisibleImageSelector> createState() => _VisibleImageSelectorState();
}

class _VisibleImageSelectorState extends State<VisibleImageSelector> {
  XFile? selectedImage;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: pickImage,
          child: const Text("Scegli immagine visibile"),
        ),
        const SizedBox(height: 12),
        if (selectedImage != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              File(selectedImage!.path),
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
      ],
    );
  }
}