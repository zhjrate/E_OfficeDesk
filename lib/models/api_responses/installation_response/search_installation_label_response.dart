class SearchInstallationLabelResponse {
  List<SearchInstallationLabelDetails> details;
  int totalCount;

  SearchInstallationLabelResponse({this.details, this.totalCount});

  SearchInstallationLabelResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = <SearchInstallationLabelDetails>[];
      json['details'].forEach((v) {
        details.add(new SearchInstallationLabelDetails.fromJson(v));
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

class SearchInstallationLabelDetails {
  String label;
  int value;
  int pkID;
  String installationNo;

  SearchInstallationLabelDetails({this.label, this.value, this.pkID, this.installationNo});

  SearchInstallationLabelDetails.fromJson(Map<String, dynamic> json) {
    label = json['label']==null?"":json['label'];
    value = json['value']==null?0:json['value'];
    pkID = json['pkID']==null?0:json['pkID'];
    installationNo = json['InstallationNo']==null?"":json['InstallationNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    data['pkID'] = this.pkID;
    data['InstallationNo'] = this.installationNo;
    return data;
  }
}