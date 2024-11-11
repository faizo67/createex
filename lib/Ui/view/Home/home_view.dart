import 'dart:convert';

import 'package:faizahmad_createex/Ui/shared/commonWidget/containerImage.dart';
import 'package:faizahmad_createex/Ui/shared/constant/size.dart';
import 'package:faizahmad_createex/Ui/view/Home/controller/home_controller.dart';
import 'package:faizahmad_createex/Ui/view/Home/profileView/paracticeProfile.dart';
import 'package:faizahmad_createex/core/model/circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CirclesScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  final String token;

  CirclesScreen({super.key, required this.token});
  @override
  Widget build(BuildContext context) {
    controller.fetchCircles(token);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome to Circle',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        actions: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.asset(
              'lib/core/images/HomeImage.png',
            ),
          ),
          SizedBox(
            width: Csize.spaceBtwItem,
          )
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.circles.isEmpty) {
          return Center(child: Text('No circles available.'));
        }

        return ListView.builder(
          itemCount: controller.circles.length,
          itemBuilder: (context, index) {
            CircleElement circle = controller.circles[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    circle.circleImage,
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ),
                title: Text(circle.circleName),
                subtitle: Text(circle.description),
                onTap: () {
                  Get.to(ProfileView(token: token));
                },
              ),
            );
          },
        );
      }),
    );
  }
}
