class DailyActivityListResponse {
  List<DailyActivityDetails> details;
  int totalCount;

  DailyActivityListResponse({this.details, this.totalCount});

  DailyActivityListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new DailyActivityDetails.fromJson(v));
      });
    }
    totalCount = json['TotalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    data['TotalCount'] = this.totalCount;
    return data;
  }
}

class DailyActivityDetails {
  int rowNum;
  int pkID;
  String activityDate;
  String taskDescription;
  double taskDuration;
  int taskCategoryID;
  String taskCategoryName;
  String createdEmployeeName;
  int createdEmployeeID;
  String createdBy;
  String createdDate;
  String updatedBy;
  String updatedDate;
  int taskpkID;
  String subTaskDescription;

  DailyActivityDetails(
      {this.rowNum,
      this.pkID,
      this.activityDate,
      this.taskDescription,
      this.taskDuration,
      this.taskCategoryID,
      this.taskCategoryName,
      this.createdEmployeeName,
      this.createdEmployeeID,
      this.createdBy,
      this.createdDate,
      this.updatedBy,
      this.updatedDate,
      this.taskpkID,
      this.subTaskDescription});

  DailyActivityDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum'];
    pkID = json['pkID'] == null ? 0 : json['pkID'];
    activityDate = json['ActivityDate'] == null ? "" : json['ActivityDate'];
    taskDescription =
        json['TaskDescription'] == null ? "" : json['TaskDescription'];
    taskDuration = json['TaskDuration'] == null ? 0.00 : json['TaskDuration'];
    taskCategoryID =
        json['TaskCategoryID'] == null ? 0 : json['TaskCategoryID'];
    taskCategoryName =
        json['TaskCategoryName'] == null ? "" : json['TaskCategoryName'];
    createdEmployeeName =
        json['CreatedEmployeeName'] == null ? "" : json['CreatedEmployeeName'];
    createdEmployeeID =
        json['CreatedEmployeeID'] == null ? 0 : json['CreatedEmployeeID'];
    createdBy = json['CreatedBy'] == null ? "" : json['CreatedBy'];
    createdDate = json['createdDate'] == null ? "" : json['createdDate'];
    updatedBy = json['UpdatedBy'] == null ? "" : json['UpdatedBy'];
    updatedDate =
        json['SubTaskDescription'] == null ? "" : json['SubTaskDescription'];
    taskpkID = json['TaskpkID'] == null ? 0 : json['TaskpkID'];
    subTaskDescription =
        json['SubTaskDescription'] == null ? "" : json['SubTaskDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['ActivityDate'] = this.activityDate;
    data['TaskDescription'] = this.taskDescription;
    data['TaskDuration'] = this.taskDuration;
    data['TaskCategoryID'] = this.taskCategoryID;
    data['TaskCategoryName'] = this.taskCategoryName;
    data['CreatedEmployeeName'] = this.createdEmployeeName;
    data['CreatedEmployeeID'] = this.createdEmployeeID;
    data['CreatedBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['UpdatedBy'] = this.updatedBy;
    data['UpdatedDate'] = this.updatedDate;
    data['TaskpkID'] = this.taskpkID;
    data['SubTaskDescription'] = this.subTaskDescription;
    return data;
  }
}
