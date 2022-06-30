/*ActionTaken:Test For Action Taken
ActionDescription:Test For ActionDescription
EmployeeID:49
Remarks:Test For Remarks
LoginUserID:admin
CompanyId:10032*/
class ToDoWorkLogListRequest {
  String HeaderID;
  String LoginUserID;
  String CompanyId;

  ToDoWorkLogListRequest({this.HeaderID,this.LoginUserID,this.CompanyId});

  ToDoWorkLogListRequest.fromJson(Map<String, dynamic> json) {
    HeaderID = json['HeaderID'];
    LoginUserID = json['LoginUserID'];
    CompanyId = json['CompanyId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HeaderID'] = this.HeaderID;
    data['LoginUserID'] = this.LoginUserID;
    data['CompanyId'] = this.CompanyId;

    return data;
  }
}