import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.setImage});
  final void Function(File image) setImage;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  final ImagePicker imagePicker = ImagePicker();
  File? pickedImage;
  @override
  Widget build(BuildContext context) {
    Widget content = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton.icon(
          onPressed: () async {
            final img = await imagePicker.pickImage(source: ImageSource.camera);
            if (img != null) {
              setState(() {
                pickedImage = File(img.path);
              });
              widget.setImage(pickedImage!);
            }
          },
          icon: const Icon(Icons.camera),
          label: const Text("Take Image"),
        ),
        TextButton.icon(
          onPressed: () async {
            final img =
                await imagePicker.pickImage(source: ImageSource.gallery);
            if (img != null) {
              setState(() {
                pickedImage = File(img.path);
              });
            }
            widget.setImage(pickedImage!);
          },
          icon: const Icon(Icons.camera),
          label: const Text("Select Image"),
        ),
      ],
    );
    if (pickedImage != null) {
      content = InkWell(
        onTap: () async {
          final img = await imagePicker.pickImage(source: ImageSource.gallery);
          if (img != null) {
            setState(() {
              pickedImage = File(img.path);
            });
          }
          widget.setImage(pickedImage!);
        },
        child: Image.file(
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          pickedImage!,
        ),
      );
    }
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width * 0.9,
      child: content,
    );
  }
}
