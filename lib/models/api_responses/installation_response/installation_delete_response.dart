class InstallationDeleteRespose {
  List<InstallationDeleteDetails> details;
  int totalCount;

  InstallationDeleteRespose({this.details, this.totalCount});

  InstallationDeleteRespose.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new InstallationDeleteDetails.fromJson(v));
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

class InstallationDeleteDetails {
  String column1;

  InstallationDeleteDetails({this.column1});

  InstallationDeleteDetails.fromJson(Map<String, dynamic> json) {
    column1 = json['Column1']==null?"":json['Column1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Column1'] = this.column1;
    return data;
  }
}