class ProductionActivityResponse {
  List<ProductionActivityDetails> details;
  int totalCount;

  ProductionActivityResponse({this.details, this.totalCount});

  ProductionActivityResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = <ProductionActivityDetails>[];
      json['details'].forEach((v) {
        details.add(new ProductionActivityDetails.fromJson(v));
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

class ProductionActivityDetails {
  int rowNum;
  int pkID;
  String activityDate;
  String pCno;
  String status;
  String taskDescription;
  double taskDuration;
  int taskCategoryID;
  String taskCategoryName;
  String createdBy;
  int createdEmployeeID;
  String createdEmployeeName;

  ProductionActivityDetails(
      {this.rowNum,
        this.pkID,
        this.activityDate,
        this.pCno,
        this.status,
        this.taskDescription,
        this.taskDuration,
        this.taskCategoryID,
        this.taskCategoryName,
        this.createdBy,
        this.createdEmployeeID,
        this.createdEmployeeName});

  ProductionActivityDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum']==null?0:json['RowNum'];
    pkID = json['pkID']==null?0:json['pkID'];
    activityDate = json['ActivityDate']==null?"":json['ActivityDate'];
    pCno = json['PCno']==null?"":json['PCno'];
    status = json['Status']==null?"":json['Status'];
    taskDescription = json['TaskDescription']==null?"":json['TaskDescription'];
    taskDuration = json['TaskDuration']==null?0.00:json['TaskDuration'];
    taskCategoryID = json['TaskCategoryID']==null?0:json['TaskCategoryID'];
    taskCategoryName = json['TaskCategoryName']==null?"":json['TaskCategoryName'];
    createdBy = json['CreatedBy']==null?"":json['CreatedBy'];
    createdEmployeeID = json['CreatedEmployeeID']==null?0:json['CreatedEmployeeID'];
    createdEmployeeName = json['CreatedEmployeeName']==null?"":json['CreatedEmployeeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['ActivityDate'] = this.activityDate;
    data['PCno'] = this.pCno;
    data['Status'] = this.status;
    data['TaskDescription'] = this.taskDescription;
    data['TaskDuration'] = this.taskDuration;
    data['TaskCategoryID'] = this.taskCategoryID;
    data['TaskCategoryName'] = this.taskCategoryName;
    data['CreatedBy'] = this.createdBy;
    data['CreatedEmployeeID'] = this.createdEmployeeID;
    data['CreatedEmployeeName'] = this.createdEmployeeName;
    return data;
  }
}