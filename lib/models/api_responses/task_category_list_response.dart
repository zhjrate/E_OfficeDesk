class TaskCategoryResponse {
  List<Details> details;
  int totalCount;

  TaskCategoryResponse({this.details, this.totalCount});

  TaskCategoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details =[];
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
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

class Details {
  int rowNum;
  int pkID;
  String taskCategoryName;

  Details({this.rowNum, this.pkID, this.taskCategoryName});

  Details.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum'];
    pkID = json['pkID'];
    taskCategoryName = json['TaskCategoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['TaskCategoryName'] = this.taskCategoryName;
    return data;
  }
}