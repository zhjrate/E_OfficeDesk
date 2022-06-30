class MenuRightsResponse {
  List<MenuDetails> details;
  int totalCount;

  MenuRightsResponse({this.details, this.totalCount});

  MenuRightsResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new MenuDetails.fromJson(v));
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

class MenuDetails {
  int pkID;
  String menuText;
  String menuName;
  int parentID;
  int menuOrder;
  bool activeStatus;
  int menuLevel;
  String menuURL;
  String path;
  int pkID1;
  String roleCode;
  int menuId;
  String createdBy;
  String createdDate;

  MenuDetails(
      {this.pkID,
        this.menuText,
        this.menuName,
        this.parentID,
        this.menuOrder,
        this.activeStatus,
        this.menuLevel,
        this.menuURL,
        this.path,
        this.pkID1,
        this.roleCode,
        this.menuId,
        this.createdBy,
        this.createdDate});

  MenuDetails.fromJson(Map<String, dynamic> json) {
    pkID = json['pkID'];
    menuText = json['MenuText'];
    menuName = json['MenuName'];
    parentID = json['parentID'];
    menuOrder = json['MenuOrder'];
    activeStatus = json['ActiveStatus'];
    menuLevel = json['MenuLevel'];
    menuURL = json['MenuURL'];
    path = json['Path'];
    pkID1 = json['pkID1'];
    roleCode = json['RoleCode'];
    menuId = json['MenuId'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkID'] = this.pkID;
    data['MenuText'] = this.menuText;
    data['MenuName'] = this.menuName;
    data['parentID'] = this.parentID;
    data['MenuOrder'] = this.menuOrder;
    data['ActiveStatus'] = this.activeStatus;
    data['MenuLevel'] = this.menuLevel;
    data['MenuURL'] = this.menuURL;
    data['Path'] = this.path;
    data['pkID1'] = this.pkID1;
    data['RoleCode'] = this.roleCode;
    data['MenuId'] = this.menuId;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    return data;
  }
}