class ExpenseListResponse {
  List<ExpenseDetails> details;
  int totalCount;

  ExpenseListResponse({this.details, this.totalCount});

  ExpenseListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new ExpenseDetails.fromJson(v));
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

class ExpenseDetails {
  int rowNum;
  int pkID;
  String expenseDate;
  int expenseTypeId;
  String expenseTypeName;
  double amount;
  String expenseNotes;
  String expenseImage;
  String fromLocation;
  String toLocation;
  String createdBy;
  String createdDate;
  String updatedBy;
  String updatedDate;
  String employeeName;
  int employeeID;

  ExpenseDetails(
      {this.rowNum,
        this.pkID,
        this.expenseDate,
        this.expenseTypeId,
        this.expenseTypeName,
        this.amount,
        this.expenseNotes,
        this.expenseImage,
        this.fromLocation,
        this.toLocation,
        this.createdBy,
        this.createdDate,
        this.updatedBy,
        this.updatedDate,
        this.employeeName,
        this.employeeID
      });

  ExpenseDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum'] == null ? 0 : json['RowNum'];
    pkID = json['pkID']== null ? 0 : json['pkID'];
    expenseDate = json['ExpenseDate']== null ? "" : json['ExpenseDate'];
    expenseTypeId = json['ExpenseTypeId']== null ? 0 : json['ExpenseTypeId'];
    expenseTypeName = json['ExpenseTypeName']== null ? "" : json['ExpenseTypeName'];
    amount = json['Amount']== null ? 0.00 : json['Amount'];
    expenseNotes = json['ExpenseNotes']== null ? "" : json['ExpenseNotes'];
    expenseImage = json['ExpenseImage']== null ? "" : json['ExpenseImage'];
    fromLocation = json['FromLocation']== null ? "" : json['FromLocation'];
    toLocation = json['ToLocation']== null ? "" : json['ToLocation'];
    createdBy = json['CreatedBy']== null ? "" : json['CreatedBy'];
    createdDate = json['CreatedDate']== null ? "" : json['CreatedDate'];
    updatedBy = json['UpdatedBy']== null ? "" : json['UpdatedBy'];
    updatedDate = json['UpdatedDate']== null ? "" : json['UpdatedDate'];
    employeeName = json['EmployeeName']== null ? "" : json['EmployeeName'];
    employeeID = json['EmployeeID']== null ? 0 : json['EmployeeID'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['ExpenseDate'] = this.expenseDate;
    data['ExpenseTypeId'] = this.expenseTypeId;
    data['ExpenseTypeName'] = this.expenseTypeName;
    data['Amount'] = this.amount;
    data['ExpenseNotes'] = this.expenseNotes;
    data['ExpenseImage'] = this.expenseImage;
    data['FromLocation'] = this.fromLocation;
    data['ToLocation'] = this.toLocation;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['UpdatedBy'] = this.updatedBy;
    data['UpdatedDate'] = this.updatedDate;
    data['EmployeeName'] = this.employeeName;
    data['EmployeeID'] = this.employeeID;

    return data;
  }
}