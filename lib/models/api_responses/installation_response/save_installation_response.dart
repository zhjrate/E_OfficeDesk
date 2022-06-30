class SaveInstallationResponse {
  List<SaveInstallationDeatails> details;
  int totalCount;

  SaveInstallationResponse({this.details, this.totalCount});

  SaveInstallationResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new SaveInstallationDeatails.fromJson(v));
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

class SaveInstallationDeatails {
  int column1;
  String column2;
  String column3;

  SaveInstallationDeatails({this.column1, this.column2, this.column3});

  SaveInstallationDeatails.fromJson(Map<String, dynamic> json) {
    column1 = json['Column1']==null?0:json['Column1'];
    column2 = json['Column2']==null?"":json['Column2'];
    column3 = json['Column3']==null?"":json['Column3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Column1'] = this.column1;
    data['Column2'] = this.column2;
    data['Column3'] = this.column3;
    return data;
  }
}