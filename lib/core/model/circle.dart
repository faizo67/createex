import 'dart:convert';

Circle circleFromJson(String str) => Circle.fromJson(json.decode(str));

String circleToJson(Circle data) => json.encode(data.toJson());

class Circle {
  bool success;
  String message;
  List<CircleElement> circles;

  // Constructor with required fields
  Circle({
    required this.success,
    required this.message,
    required this.circles,
  });

  // Factory method for JSON deserialization
  factory Circle.fromJson(Map<String, dynamic> json) => Circle(
    success: json["success"],
    message: json["message"],
    // Ensure that 'circles' is a valid list or an empty list if null
    circles: json["circles"] == null
        ? []
        : List<CircleElement>.from(json["circles"].map((x) => CircleElement.fromJson(x))),
  );

  // Convert Circle object to JSON
  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "circles": List<dynamic>.from(circles.map((x) => x.toJson())),
  };
}

class CircleElement {
  String id;
  String circleName;
  String circleImage;
  String description;

  // Constructor for CircleElement
  CircleElement({
    required this.id,
    required this.circleName,
    required this.circleImage,
    required this.description,
  });

  // Factory method to convert JSON to CircleElement
  factory CircleElement.fromJson(Map<String, dynamic> json) => CircleElement(
    id: json["_id"],
    circleName: json["circleName"],
    circleImage: json["circleImage"],
    description: json["description"],
  );

  // Convert CircleElement object to JSON
  Map<String, dynamic> toJson() => {
    "_id": id,
    "circleName": circleName,
    "circleImage": circleImage,
    "description": description,
  };
}
