class DistanceMatrix_Request {
  String origins;
  String destinations;
  String Key;

  DistanceMatrix_Request({this.origins,this.destinations,this.Key});

  DistanceMatrix_Request.fromJson(Map<String, dynamic> json) {
    origins = json['origins'];
    destinations = json['destinations'];
    Key = json['Key'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['origins'] = this.origins;
    data['destinations'] = this.destinations;
    data['Key'] = this.Key;
    return data;
  }
}