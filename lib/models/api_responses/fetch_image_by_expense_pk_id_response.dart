class FetchImageListByExpensePKID_Response {
  List<ImageListDetails> details;
  int totalCount;

  FetchImageListByExpensePKID_Response({this.details, this.totalCount});

  FetchImageListByExpensePKID_Response.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new ImageListDetails.fromJson(v));
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

class ImageListDetails {
  int pkID;
  int expenseID;
  String name;
  String type;
  String employeeName;
  String createdBy;
  String createdDate;

  ImageListDetails(
      {this.pkID,
        this.expenseID,
        this.name,
        this.type,
        this.employeeName,
        this.createdBy,
        this.createdDate});

  ImageListDetails.fromJson(Map<String, dynamic> json) {
    pkID = json['pkID'];
    expenseID = json['ExpenseID'];
    name = json['Name'];
    type = json['Type'];
    employeeName = json['EmployeeName'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkID'] = this.pkID;
    data['ExpenseID'] = this.expenseID;
    data['Name'] = this.name;
    data['Type'] = this.type;
    data['EmployeeName'] = this.employeeName;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    return data;
  }
}