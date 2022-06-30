class TalukaApiRequest {
  String CompanyId;
  String TalukaName;
  String DistrictCode;

  TalukaApiRequest({this.CompanyId,this.TalukaName,this.DistrictCode});

  TalukaApiRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    TalukaName = json['TalukaName'];
    DistrictCode = json['DistrictCode'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['TalukaName'] = this.TalukaName;
    data['DistrictCode'] = this.DistrictCode;
    return data;
  }
}