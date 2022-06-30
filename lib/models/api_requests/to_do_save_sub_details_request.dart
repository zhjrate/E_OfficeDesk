/*ActionTaken:Test For Action Taken
ActionDescription:Test For ActionDescription
EmployeeID:49
Remarks:Test For Remarks
LoginUserID:admin
CompanyId:10032*/
class ToDoSaveSubDetailsRequest {
 String ActionTaken;
 String ActionDescription;
 String EmployeeID;
 String Remarks;
 String LoginUserID;
 String CompanyId;

  ToDoSaveSubDetailsRequest({this.ActionTaken,this.ActionDescription,this.EmployeeID,this.Remarks,this.LoginUserID,this.CompanyId});

  ToDoSaveSubDetailsRequest.fromJson(Map<String, dynamic> json) {
    ActionTaken = json['ActionTaken'];
    ActionDescription = json['ActionDescription'];
    EmployeeID = json['EmployeeID'];
    Remarks = json['Remarks'];
    LoginUserID = json['LoginUserID'];
    CompanyId = json['CompanyId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ActionTaken'] = this.ActionTaken;
    data['ActionDescription'] = this.ActionDescription;
    data['EmployeeID'] = this.EmployeeID;
    data['Remarks'] = this.Remarks;
    data['LoginUserID'] = this.LoginUserID;
    data['CompanyId'] = this.CompanyId;

    return data;
  }
}