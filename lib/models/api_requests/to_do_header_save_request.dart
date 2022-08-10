class ToDoHeaderSaveRequest {
  String Priority;
  String TaskDescription;
  String Location;
  String TaskCategoryID;
  String StartDate;
  String DueDate;
  String CompletionDate;
  String LoginUserID;
  String EmployeeID;
  String Reminder;
  String ReminderMonth;
  String Latitude;
  String Longitude;
  String ClosingRemarks;
  String CompanyId;

  ToDoHeaderSaveRequest(
      {this.Priority,
      this.TaskDescription,
      this.Location,
      this.TaskCategoryID,
      this.StartDate,
      this.DueDate,
      this.CompletionDate,
      this.LoginUserID,
      this.EmployeeID,
      this.Reminder,
      this.ReminderMonth,
      this.Latitude,
      this.Longitude,
      this.ClosingRemarks,
      this.CompanyId});

  /*Priority:High
TaskDescription:Test For ToDo Check In Live
Location:Sharvaya Test
TaskCategoryID:6
StartDate:2022-01-25
DueDate:2022-01-26
CompletionDate:2022-01-25
LoginUserID:admin
EmployeeID:49
Reminder:
ReminderMonth:
Latitude:
Longitude:
ClosingRemarks:Test INS Done And Check For Update Now
CompanyId:10032*/

  // ToDoHeaderSaveRequest({this.CompanyId,this.pkID,this.StatusCategory,this.LoginUserID,this.SearchKey});

  ToDoHeaderSaveRequest.fromJson(Map<String, dynamic> json) {
    Priority = json['Priority'];
    TaskDescription = json['TaskDescription'];
    Location = json['Location'];
    TaskCategoryID = json['TaskCategoryID'];
    StartDate = json['StartDate'];
    DueDate = json['DueDate'];
    CompletionDate = json['CompletionDate'];
    LoginUserID = json['LoginUserID'];
    EmployeeID = json['EmployeeID'];
    Reminder = json['Reminder'];
    ReminderMonth = json['ReminderMonth'];
    Latitude = json['Latitude'];
    Longitude = json['Longitude'];
    ClosingRemarks = json['ClosingRemarks'];
    CompanyId = json['CompanyId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Priority'] = this.Priority;
    data['TaskDescription'] = this.TaskDescription;
    data['Location'] = this.Location;
    data['TaskCategoryID'] = this.TaskCategoryID;
    data['StartDate'] = this.StartDate;
    data['DueDate'] = this.DueDate;
    data['CompletionDate'] = this.CompletionDate;
    data['LoginUserID'] = this.LoginUserID;
    data['EmployeeID'] = this.EmployeeID;
    data['Reminder'] = this.Reminder;
    data['ReminderMonth'] = this.ReminderMonth;
    data['Latitude'] = this.Latitude;
    data['Longitude'] = this.Longitude;
    data['ClosingRemarks'] = this.ClosingRemarks;
    data['CompanyId'] = this.CompanyId;

    return data;
  }
}
