// To parse this JSON data, do
//
//     final avatarModel = avatarModelFromJson(jsonString);

import 'dart:convert';

List<AvatarModel> avatarModelFromJson(String str) => List<AvatarModel>.from(
  json.decode(str).map((x) => AvatarModel.fromJson(x)),
);

String avatarModelToJson(List<AvatarModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AvatarModel {
  int id;
  String season;
  String numInSeason;
  String title;
  AnimatedBy animatedBy;
  DirectedBy directedBy;
  List<String> writtenBy;
  String originalAirDate;
  String productionCode;
  String? viewers;

  AvatarModel({
    required this.id,
    required this.season,
    required this.numInSeason,
    required this.title,
    required this.animatedBy,
    required this.directedBy,
    required this.writtenBy,
    required this.originalAirDate,
    required this.productionCode,
    this.viewers,
  });

  factory AvatarModel.fromJson(Map<String, dynamic> json) => AvatarModel(
    id: json["id"],
    season: json["Season"],
    numInSeason: json["NumInSeason"],
    title: json["Title"],
    animatedBy: animatedByValues.map[json["AnimatedBy"]]!,
    directedBy: directedByValues.map[json["DirectedBy"]]!,
    writtenBy: List<String>.from(json["WrittenBy"].map((x) => x)),
    originalAirDate: json["OriginalAirDate"],
    productionCode: json["ProductionCode "],
    viewers: json["Viewers"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "Season": season,
    "NumInSeason": numInSeason,
    "Title": title,
    "AnimatedBy": animatedByValues.reverse[animatedBy],
    "DirectedBy": directedByValues.reverse[directedBy],
    "WrittenBy": List<dynamic>.from(writtenBy.map((x) => x)),
    "OriginalAirDate": originalAirDate,
    "ProductionCode ": productionCode,
    "Viewers": viewers,
  };
}

enum AnimatedBy { DR_MOVIE, JM_ANIMATION, MOI_ANIMATION }

final animatedByValues = EnumValues({
  "DR Movie": AnimatedBy.DR_MOVIE,
  "JM Animation": AnimatedBy.JM_ANIMATION,
  "Moi Animation": AnimatedBy.MOI_ANIMATION,
});

enum DirectedBy {
  ANTHONY_LIOI,
  DAVE_FILONI,
  ETHAN_SPAULDING,
  GIANCARLO_VOLPE,
  JOAQUIM_DOS_SANTOS,
  LAUREN_MAC_MULLAN,
  MICHAEL_DANTE_DI_MARTINO,
}

final directedByValues = EnumValues({
  "Anthony Lioi": DirectedBy.ANTHONY_LIOI,
  "Dave Filoni": DirectedBy.DAVE_FILONI,
  "Ethan Spaulding": DirectedBy.ETHAN_SPAULDING,
  "Giancarlo Volpe": DirectedBy.GIANCARLO_VOLPE,
  "Joaquim Dos Santos": DirectedBy.JOAQUIM_DOS_SANTOS,
  "Lauren MacMullan": DirectedBy.LAUREN_MAC_MULLAN,
  "Michael Dante DiMartino": DirectedBy.MICHAEL_DANTE_DI_MARTINO,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
