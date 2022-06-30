class TaskCategoryListRequest {
  String CompanyId;
  String pkID;

  TaskCategoryListRequest({this.CompanyId,this.pkID});

  TaskCategoryListRequest.fromJson(Map<String, dynamic> json) {
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