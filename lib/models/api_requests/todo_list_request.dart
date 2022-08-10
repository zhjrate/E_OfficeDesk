class ToDoListApiRequest {
  String TaskStatus;
  String LoginUserID;
  String CompanyId;
  String EmployeeID;
  int PageNo;
  int PageSize;

  /*

TaskTitle:
TaskStatus:Completed
LoginUserID:admin
CompanyId:10032
Month:
Year:
EmployeeID:49
PageNo:1
PageSize:11
  */

  ToDoListApiRequest(
      {this.TaskStatus,
      this.LoginUserID,
      this.CompanyId,
      this.EmployeeID,
      this.PageNo,
      this.PageSize});

  ToDoListApiRequest.fromJson(Map<String, dynamic> json) {
    TaskStatus = json['TaskStatus'];
    LoginUserID = json['LoginUserID'];
    CompanyId = json['CompanyId'];
    PageNo = json['PageNo'];
    PageSize = json['PageSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TaskTitle'] = "";
    data['TaskStatus'] = this.TaskStatus;
    data['LoginUserID'] = this.LoginUserID;
    data['CompanyId'] = this.CompanyId;
    data['Month'] = "";
    data['Year'] = "";
    data['EmployeeID'] = this.EmployeeID;
    data['PageNo'] = 1;
    data['PageSize'] = 100000;

    return data;
  }
}
