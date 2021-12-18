// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

SpeechResponse speechResponseFromJson(String str) => SpeechResponse.fromJson(json.decode(str));

String speechResponseToJson(SpeechResponse data) => json.encode(data.toJson());

class SpeechResponse {
  SpeechResponse({
    this.definitions,
    this.word,
    this.pronunciation,
  });

  List<Definition>? definitions;
  String? word;
  String? pronunciation;

  factory SpeechResponse.fromJson(Map<String, dynamic> json) => SpeechResponse(
    definitions: List<Definition>.from(json["definitions"].map((x) => Definition.fromJson(x))),
    word: json["word"],
    pronunciation: json["pronunciation"],
  );

  Map<String, dynamic> toJson() => {
    "definitions": List<dynamic>.from(definitions!.map((x) => x.toJson())),
    "word": word,
    "pronunciation": pronunciation,
  };
}

class Definition {
  Definition({
    this.type,
    this.definition,
    this.example,
    this.imageUrl,
    this.emoji,
  });

  String? type;
  String? definition;
  String? example;
  String? imageUrl;
  String? emoji;

  factory Definition.fromJson(Map<String, dynamic> json) => Definition(
    type: json["type"],
    definition: json["definition"],
    example: json["example"],
    imageUrl: json["image_url"],
    emoji: json["emoji"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "definition": definition,
    "example": example,
    "image_url": imageUrl,
    "emoji": emoji,
  };
}
