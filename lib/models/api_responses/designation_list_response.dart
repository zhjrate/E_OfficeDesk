class DesignationApiResponse {
  List<Details> details;
  int totalCount;

  DesignationApiResponse({this.details, this.totalCount});

  DesignationApiResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
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
  String desigCode;
  String designation;
  bool activeFlag;
  String activeFlagDesc;

  Details(
      {this.rowNum,
        this.desigCode,
        this.designation,
        this.activeFlag,
        this.activeFlagDesc});

  Details.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum'];
    desigCode = json['DesigCode'];
    designation = json['Designation'];
    activeFlag = json['ActiveFlag'];
    activeFlagDesc = json['ActiveFlagDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['DesigCode'] = this.desigCode;
    data['Designation'] = this.designation;
    data['ActiveFlag'] = this.activeFlag;
    data['ActiveFlagDesc'] = this.activeFlagDesc;
    return data;
  }
}