class AttendanceApiRequest {
  String pkID;
  String EmployeeID;
  String Month;
  String Year;
  String CompanyId;
  String LoginUserID;

  /*

  pkID:
EmployeeID:57
Month:
Year:
CompanyId:8033
  */

  AttendanceApiRequest({this.pkID,this.EmployeeID,this.Month,this.Year,this.CompanyId,this.LoginUserID});

  AttendanceApiRequest.fromJson(Map<String, dynamic> json) {
    pkID = json['pkID'];
    EmployeeID = json['EmployeeID'];
    Month = json['Month'];
    Year = json['Year'];
    CompanyId = json['CompanyId'];
    LoginUserID = json['LoginUserID'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkID'] = this.pkID;
    data['EmployeeID'] = this.EmployeeID;
    data['Month'] = this.Month;
    data['Year'] = this.Year;
    data['CompanyId'] = this.CompanyId;
    data['LoginUserID'] = this.LoginUserID;

    return data;
  }
}