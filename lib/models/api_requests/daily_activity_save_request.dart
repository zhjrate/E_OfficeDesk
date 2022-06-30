class DailyActivitySaveRequest {
  String CompanyId;
  String ActivityDate;
  String TaskCategoryID;
  String TaskDescription;
  String TaskDuration;
  String LoginUserID;






  DailyActivitySaveRequest({this.CompanyId,this.ActivityDate,this.TaskCategoryID,this.TaskDescription,this.TaskDuration,this.LoginUserID});

  DailyActivitySaveRequest.fromJson(Map<String, dynamic> json) {
    CompanyId = json['CompanyId'];
    ActivityDate = json['ActivityDate'];
    TaskCategoryID = json['TaskCategoryID'];
    TaskDescription = json['TaskDescription'];
    TaskDuration = json['TaskDuration'];
    LoginUserID = json['LoginUserID'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyId'] = this.CompanyId;
    data['ActivityDate'] = this.ActivityDate;
    data['TaskCategoryID'] = this.TaskCategoryID;
    data['TaskDescription'] = this.TaskDescription;
    data['TaskDuration'] = this.TaskDuration;
    data['LoginUserID'] = this.LoginUserID;

    return data;
  }
}