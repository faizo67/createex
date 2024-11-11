import 'dart:typed_data';

import 'package:faizahmad_createex/Ui/shared/commonWidget/customBtn.dart';
import 'package:faizahmad_createex/Ui/shared/commonWidget/stackImage.dart';
import 'package:faizahmad_createex/Ui/shared/constant/size.dart';
import 'package:faizahmad_createex/Ui/view/Home/controller/home_controller.dart';
import 'package:faizahmad_createex/core/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileView extends StatefulWidget {
  final String token;

  ProfileView({Key? key, required this.token}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final LoginController profileController = Get.put(LoginController());

    // Fetch profile data using the provided token
    profileController.getProfile(widget.token);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile View'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Obx(() {
            // Check if loading
            if (profileController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }

            // Check if profile data is available
            final ProfileModel? profile = profileController.userProfile.value;
            if (profile == null) {
              return Center(child: Text('No profile data available.'));
            }

            // Profile UI
            final Data userData = profile.data;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Profile',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),

                  // Profile Picture

                  Stackimage(
                    imageUrl: userData.profilePicture,
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        Uint8List bytes = await image.readAsBytes();
                        profileController
                            .uploadImage(widget.token, bytes, image.name)
                            .then(
                          (value) {
                            setState(() {});
                            print("Upload Succesfully");
                          },
                        );
                      }
                    },
                  ),

                  SizedBox(height: 20),

                  // Name
                  ListTile(
                    title: Text(
                      'Name',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      userData.name.isNotEmpty
                          ? userData.name
                          : 'No name available',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),

                  // Email
                  ListTile(
                    title: Text(
                      'Email',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      userData.email.isNotEmpty
                          ? userData.email
                          : 'No email available',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),

                  SizedBox(
                    height: Csize.spaceBtwItem * 18,
                  ),

                  // Update Profile Button
                  CustomBtn(title: 'Update'),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
