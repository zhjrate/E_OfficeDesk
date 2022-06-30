class LocationAddressRequest {
  String key;
  String latlng;

  LocationAddressRequest({this.key,this.latlng});

  LocationAddressRequest.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    latlng = json['latlng'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['latlng'] = this.latlng;

    return data;
  }
}