class TransectionModeListResponse {
  List<TransectionDetails> details;
  int totalCount;

  TransectionModeListResponse({this.details, this.totalCount});

  TransectionModeListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new TransectionDetails.fromJson(v));
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

class TransectionDetails {
  int pkID;
  String walletName;

  TransectionDetails({this.pkID, this.walletName});

  TransectionDetails.fromJson(Map<String, dynamic> json) {
    pkID = json['pkID'];
    walletName = json['WalletName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkID'] = this.pkID;
    data['WalletName'] = this.walletName;
    return data;
  }
}