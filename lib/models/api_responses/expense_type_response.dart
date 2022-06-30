class ExpenseTypeResponse {
  List<ExpenseTypeDetails> details;
  int totalCount;

  ExpenseTypeResponse({this.details, this.totalCount});

  ExpenseTypeResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new ExpenseTypeDetails.fromJson(v));
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

class ExpenseTypeDetails {
  int pkID;
  String expenseTypeName;
  bool isLocationRequired;

  ExpenseTypeDetails({this.pkID, this.expenseTypeName, this.isLocationRequired});

  ExpenseTypeDetails.fromJson(Map<String, dynamic> json) {
    pkID = json['pkID'];
    expenseTypeName = json['ExpenseTypeName'];
    isLocationRequired = json['IsLocationRequired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkID'] = this.pkID;
    data['ExpenseTypeName'] = this.expenseTypeName;
    data['IsLocationRequired'] = this.isLocationRequired;
    return data;
  }
}