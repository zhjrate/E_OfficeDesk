class InstallationCityResponse {
  List<InstallationCityDetails> details;
  int totalCount;

  InstallationCityResponse({this.details, this.totalCount});

  InstallationCityResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new InstallationCityDetails.fromJson(v));
      });
    }
    totalCount = json['TotalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    data['TotalCount'] = this.totalCount;
    return data;
  }
}

class InstallationCityDetails {
  String stateCode;
  int cityCode;
  String cityName;

  InstallationCityDetails({this.stateCode, this.cityCode, this.cityName});

  InstallationCityDetails.fromJson(Map<String, dynamic> json) {
    stateCode = json['StateCode']==null?"":json['StateCode'];
    cityCode = json['CityCode']==null?0:json['CityCode'];
    cityName = json['CityName']==null?"":json['CityName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StateCode'] = this.stateCode;
    data['CityCode'] = this.cityCode;
    data['CityName'] = this.cityName;
    return data;
  }
}