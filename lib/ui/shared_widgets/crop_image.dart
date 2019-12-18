import 'package:flutter/material.dart';
import 'dart:convert';

///Crops Image from assets to cover a given height
///
///Default [CropImage.imageHeight] is 400
class CropImage extends StatelessWidget {
  final String _encodedImage;
  final String _assetImage;
  final double _imageHeight;

  const CropImage({
    Key key,
    imageHeight = 300,
    encodedImage,
    assetImage = 'assets/images/thai-restaurant.jpg',
  })  : _imageHeight = imageHeight,
        _assetImage = assetImage,
        _encodedImage = encodedImage,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _imageHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: _encodedImage == null
              ? AssetImage(_assetImage)
              : Image.memory(base64Decode(_encodedImage)).image,
        ),
      ),
    );
  }
}
