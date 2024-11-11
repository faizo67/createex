// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
    bool success;
    Data data;

    ProfileModel({
        required this.success,
        required this.data,
    });

    factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
    };
}

class Data {
    String id;
    String phoneNumber;
    String name;
    String email;
    String profilePicture;

    Data({
        required this.id,
        required this.phoneNumber,
        required this.name,
        required this.email,
        required this.profilePicture,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        phoneNumber: json["phoneNumber"],
        name: json["name"],
        email: json["email"],
        profilePicture: json["profilePicture"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "phoneNumber": phoneNumber,
        "name": name,
        "email": email,
        "profilePicture": profilePicture,
    };
}
