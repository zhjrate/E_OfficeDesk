class DailyActivityListRequest {
  int CompanyId;
  String LoginUserID;
  String EmployeeID;
  String ActivityDate;



  /*

ActivityDate:2020-10-06
EmployeeID:
LoginUserID:admin
CompanyId:10032
  */



  DailyActivityListRequest({this.CompanyId,this.LoginUserID,this.EmployeeID,this.ActivityDate});

  DailyActivityListRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    LoginUserID = json['LoginUserID'];
    EmployeeID=json['EmployeeID'];
    ActivityDate=json['ActivityDate'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['LoginUserID'] = this.LoginUserID;
    data['EmployeeID']=this.EmployeeID;
    data['ActivityDate']=this.ActivityDate;


    return data;
  }
}