class InquiryShareModel {

  String InquiryNo,EmployeeName,EmployeeID,LoginUserID,CompanyId;
  bool ISCHECKED;
  InquiryShareModel(this.LoginUserID,this.EmployeeID, this.CompanyId,this.InquiryNo,this.ISCHECKED,this.EmployeeName);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['InquiryNo'] = this.InquiryNo;
    data['EmployeeID'] = this.EmployeeID;

    data['LoginUserID'] = this.LoginUserID;
    data['CompanyId'] = this.CompanyId;
    data['ISCHECKED'] = this.ISCHECKED;
    data['EmployeeName'] = this.EmployeeName;


    return data;
  }

  @override
  String toString() {
    return 'InquiryShareModel{EmployeeID: $EmployeeID, InquiryNo: $InquiryNo,LoginUserID: $LoginUserID, CompanyId: $CompanyId,ISCHECKED:$ISCHECKED,EmployeeName:$EmployeeName}';
  }
}