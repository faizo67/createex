import 'dart:convert';
import 'package:faizahmad_createex/Ui/view/Home/home_view.dart';
import 'package:faizahmad_createex/core/model/circle.dart';
import 'package:faizahmad_createex/core/model/profile_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  var userProfile = Rxn<ProfileModel>();
  var circle = <Circle>[].obs;
  RxList<CircleElement> circles = <CircleElement>[].obs;

  var isLoading = false.obs;

  // API URL
  final String apiUrl = 'https://cricle-app.azurewebsites.net/api/circle/all';

  // Login API
  void loginApi() async {
    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse('https://cricle-app.azurewebsites.net/api/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": emailController.value.text,
          "password": passwordController.value.text,
        }),
      );

      isLoading.value = false;
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        String token = data['token'];
        Get.snackbar('Login Successful', data['message']);
        print("User token: $token");

        // Fetch profile and circles after successful login
        await getProfile(token);
        await fetchCircles(token);

        Get.offAll(() => CirclesScreen(token: token));
      } else {
        Get.snackbar('Login Failed', data['message']);
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Exception', e.toString());
    }
  }

// Fetch profile data using token
  Future<ProfileModel?> getProfile(String token) async {
    isLoading.value = true;
    final String apiUrl =
        "https://cricle-app.azurewebsites.net/api/auth/profile";

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $token', // Use the token to authenticate the request
        },
      );

      if (response.statusCode == 200) {
        // Parse the JSON response into a ProfileModel object
        final ProfileModel profileData = profileModelFromJson(response.body);
        userProfile.value = profileData; // Update the observable
        return profileData;
      } else {
        Get.snackbar('Error', 'Failed to load profile');
        return null;
      }
    } catch (e) {
      Get.snackbar('Exception', e.toString());
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch Circle's Data
  Future<void> fetchCircles(String token) async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        Circle circleData = Circle.fromJson(data);

        if (circleData.success) {
          circles.value = circleData.circles;
        } else {
          Get.snackbar('Error', circleData.message);
        }
      } else {
        Get.snackbar('Error', 'Failed to load circles');
      }
    } catch (e) {
      Get.snackbar('Exception', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<dynamic> uploadImage(
      String token, Uint8List bytes, String fileName) async {
    Uri url = Uri.parse(
        'https://cricle-app.azurewebsites.net/api/auth/update-profile-picture');
    var request = http.MultipartRequest('POST', url);
    var myFile = http.MultipartFile(
        "url", http.ByteStream.fromBytes(bytes), bytes.length);
    request.files.add(myFile);
    final response = await request.send();
    if (response.statusCode == 200) {
      var data = await response.stream.bytesToString();
      return jsonDecode(data);
    } else {
      return null;
    }
  }
}
