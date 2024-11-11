import 'package:faizahmad_createex/Ui/shared/commonWidget/containerImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Stackimage extends StatelessWidget {
  Stackimage({super.key, required this.imageUrl, required this.onTap});
  String? imageUrl;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          // Image Contianer
          Containerimage(
            height: 114,
            width: 114,
            imageUrl: imageUrl!,
          ),
          // Image Icons
          Positioned(
              left: 75,
              top: 75,
              child: Stack(
                children: [
                  // Black Circle
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  // Icon
                  Positioned(
                      left: 7,
                      top: 6,
                      child: Icon(
                        Icons.camera,
                        color: Colors.white,
                      )),
                ],
              )),
        ],
      ),
    );
  }
}
