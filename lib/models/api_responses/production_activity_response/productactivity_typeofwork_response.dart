class TypeOfWorkResponse {
  List<TypeOfWorkDetails> details;
  int totalCount;

  TypeOfWorkResponse({this.details, this.totalCount});

  TypeOfWorkResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new TypeOfWorkDetails.fromJson(v));
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

class TypeOfWorkDetails {
  int rowNum;
  int pkID;
  String taskCategoryName;

  TypeOfWorkDetails({this.rowNum, this.pkID, this.taskCategoryName});

  TypeOfWorkDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum']==null?0:json['RowNum'];
    pkID = json['pkID']==null?0:json['pkID'];
    taskCategoryName = json['TaskCategoryName']==null?"":json['TaskCategoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['TaskCategoryName'] = this.taskCategoryName;
    return data;
  }
}