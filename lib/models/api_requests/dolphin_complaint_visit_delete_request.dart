class DolphinComplaintVisitDeleteRequest {
  String pkID;
  String CompanyID;

  DolphinComplaintVisitDeleteRequest({this.pkID,this.CompanyID});

  DolphinComplaintVisitDeleteRequest.fromJson(Map<String, dynamic> json) {
    pkID = json['pkID'];
    CompanyID = json['CompanyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkID']=this.pkID;
    data['CompanyId'] = this.CompanyID;

    return data;
  }
}