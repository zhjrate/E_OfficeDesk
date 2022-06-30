class TypeOfWorkRequest {
  String pkID;
  String CompanyId;

  TypeOfWorkRequest({this.pkID,this.CompanyId});

  TypeOfWorkRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    pkID = json['pkID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['pkID'] = this.pkID;
    return data;
  }
}

