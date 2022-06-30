class PlaceSearchRequest {
  String query;
  String MapAPIKey;

  PlaceSearchRequest({this.query,this.MapAPIKey});

  PlaceSearchRequest.fromJson(Map<String, dynamic> json) {
    query = json['query'];
    MapAPIKey = json['MapAPIKey'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['query'] = this.query;
    data['MapAPIKey'] = this.MapAPIKey;


    return data;
  }
}