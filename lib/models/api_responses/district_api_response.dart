class DistrictApiResponse {
  List<SearchDistrictDetails> details;
  int totalCount;

  DistrictApiResponse({this.details, this.totalCount});

  DistrictApiResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new SearchDistrictDetails.fromJson(v));
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

class SearchDistrictDetails {
  int districtCode;
  String districtName;

  SearchDistrictDetails({this.districtCode, this.districtName});

  SearchDistrictDetails.fromJson(Map<String, dynamic> json) {
    districtCode = json['DistrictCode'];
    districtName = json['DistrictName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DistrictCode'] = this.districtCode;
    data['DistrictName'] = this.districtName;
    return data;
  }
}