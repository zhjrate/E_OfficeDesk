class QuotationProjectListResponse {
  List<QuotationProjectDetails> details;
  int totalCount;

  QuotationProjectListResponse({this.details, this.totalCount});

  QuotationProjectListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new QuotationProjectDetails.fromJson(v));
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

class QuotationProjectDetails {
 /* int rowNum;
  int pkID;*/
  int pkID;
  String projectName;
/*  String projectDescription;
  String startDate;
  String dueDate;
  String completionDate;*/

  QuotationProjectDetails({this.pkID,this.projectName});
 /* QuotationProjectDetails(
      {this.rowNum,
        this.pkID,
        this.projectName,
        this.projectDescription,
        this.startDate,
        this.dueDate,
        this.completionDate});*/

  QuotationProjectDetails.fromJson(Map<String, dynamic> json) {
  /*  rowNum = json['RowNum'];
    pkID = json['pkID'];*/
    pkID = json['pkID'];
    projectName = json['ProjectName'];
  /*  projectDescription = json['ProjectDescription'];
    startDate = json['StartDate'];
    dueDate = json['DueDate'];
    completionDate = json['CompletionDate'];*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
   /* data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;*/
    data['pkID'] = this.pkID;
    data['ProjectName'] = this.projectName;
    /*data['ProjectDescription'] = this.projectDescription;
    data['StartDate'] = this.startDate;
    data['DueDate'] = this.dueDate;
    data['CompletionDate'] = this.completionDate;*/
    return data;
  }
}