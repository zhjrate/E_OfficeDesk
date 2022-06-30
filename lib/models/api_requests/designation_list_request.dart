class DesignationApiRequest {
  String CompanyId;
  String DesigCode;

  DesignationApiRequest({this.CompanyId,this.DesigCode});

  DesignationApiRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    DesigCode = json['DesigCode'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['DesigCode'] = this.DesigCode;

    return data;
  }
}