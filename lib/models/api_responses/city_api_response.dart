class CityApiRespose {
  List<SearchCityDetails> details;
  int totalCount;

  CityApiRespose({this.details, this.totalCount});

  CityApiRespose.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new SearchCityDetails.fromJson(v));
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

class SearchCityDetails {
  int cityCode;
  String cityName;

  SearchCityDetails({this.cityCode, this.cityName});

  SearchCityDetails.fromJson(Map<String, dynamic> json) {
    cityCode = json['CityCode'];
    cityName = json['CityName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CityCode'] = this.cityCode;
    data['CityName'] = this.cityName;
    return data;
  }
}