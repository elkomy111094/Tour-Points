class PlacesResponse {
  int? statusCode;
  bool? success;
  List<Place>? placesList;
  String? message;

  PlacesResponse(
      {this.statusCode, this.success, this.placesList, this.message});

  PlacesResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    success = json['success'];
    if (json['data'] != null) {
      placesList = <Place>[];
      json['data'].forEach((v) {
        placesList!.add(new Place.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['success'] = this.success;
    if (this.placesList != null) {
      data['data'] = this.placesList!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Place {
  String? placesID;
  String? lat;
  String? longt;
  String? placeName;
  String? description;
  String? photo;

  Place(
      {this.placesID,
      this.lat,
      this.longt,
      this.placeName,
      this.description,
      this.photo});

  Place.fromJson(Map<String, dynamic> json) {
    placesID = json['PlacesID'];
    lat = json['Lat'];
    longt = json['Longt'];
    placeName = json['PlaceName'];
    description = json['description'];
    photo = json['Photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PlacesID'] = this.placesID;
    data['Lat'] = this.lat;
    data['Longt'] = this.longt;
    data['PlaceName'] = this.placeName;
    data['description'] = this.description;
    data['Photo'] = this.photo;
    return data;
  }
}
