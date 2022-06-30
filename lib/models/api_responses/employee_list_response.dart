class EmployeeListResponse {
  List<EmployeeDetails> details;
  int totalCount;

  EmployeeListResponse({this.details, this.totalCount});

  EmployeeListResponse.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details.add(new EmployeeDetails.fromJson(v));
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

class EmployeeDetails {
  int rowNum;
  int pkID;
  String employeeName;
  String cardNo;
  String mobileNo;
  String landline;
  String emailAddress;
  String emailPassword;
  String gender;
  int workingHours;
  int shiftCode;
  String shiftName;
  String basicPer;
  String desigCode;
  String designation;
  String employeeImage;
  String orgCode;
  String orgName;
  String empCode;
  int reportTo;
  String reportToEmployeeName;
  double fixedSalary;
  double fixedBasic;
  double fixedHRA;
  double fixedConv;
  double fixedDA;
  double fixedSpecial;
  String birthDate;
  String confirmationDate;
  String joinDate;
  String releaseDate;
  String authorizedSign;
  String drivingLicenseNo;
  String passportNo;
  String aadharCardNo;
  String pANCardNo;
  bool pFCalculation;
  bool pTCalculation;
  int eSICalculation;
  String eSignaturePath;
  String bankName;
  String bankBranch;
  String bankAccountNo;
  String bankIFSC;

  EmployeeDetails(
      {this.rowNum,
        this.pkID,
        this.employeeName,
        this.cardNo,
        this.mobileNo,
        this.landline,
        this.emailAddress,
        this.emailPassword,
        this.gender,
        this.workingHours,
        this.shiftCode,
        this.shiftName,
        this.basicPer,
        this.desigCode,
        this.designation,
        this.employeeImage,
        this.orgCode,
        this.orgName,
        this.empCode,
        this.reportTo,
        this.reportToEmployeeName,
        this.fixedSalary,
        this.fixedBasic,
        this.fixedHRA,
        this.fixedConv,
        this.fixedDA,
        this.fixedSpecial,
        this.birthDate,
        this.confirmationDate,
        this.joinDate,
        this.releaseDate,
        this.authorizedSign,
        this.drivingLicenseNo,
        this.passportNo,
        this.aadharCardNo,
        this.pANCardNo,
        this.pFCalculation,
        this.pTCalculation,
        this.eSICalculation,
        this.eSignaturePath,
        this.bankName,
        this.bankBranch,
        this.bankAccountNo,
        this.bankIFSC});

  EmployeeDetails.fromJson(Map<String, dynamic> json) {
    rowNum = json['RowNum']==null?0:json['RowNum'];
    pkID = json['pkID']==null?0:json['pkID'];
    employeeName = json['EmployeeName']==null?"":json['EmployeeName'];
    cardNo = json['CardNo']==null?"":json['CardNo'];
    mobileNo = json['MobileNo']==null?"":json['MobileNo'];
    landline = json['Landline']==null?"":json['Landline'];
    emailAddress = json['EmailAddress']==null?"":json['EmailAddress'];
    emailPassword = json['EmailPassword']==null?"":json['EmailPassword'];
    gender = json['Gender']==null?"":json['Gender'];
    workingHours = json['WorkingHours']==null?0:json['WorkingHours'];
    shiftCode = json['ShiftCode']==null?0:json['ShiftCode'];
    shiftName = json['ShiftName']==null?"":json['ShiftName'];
    basicPer = json['BasicPer']==null?"":json['BasicPer'];
    desigCode = json['DesigCode']==null?"":json['DesigCode'];
    designation = json['Designation']==null?"":json['Designation'];
    employeeImage = json['EmployeeImage']==null?"":json['EmployeeImage'];
    orgCode = json['OrgCode']==null?"":json['OrgCode'];
    orgName = json['OrgName']==null?"":json['OrgName'];
    empCode = json['EmpCode']==null?"":json['EmpCode'];
    reportTo = json['ReportTo']==null?"":json['ReportTo'];
    reportToEmployeeName = json['ReportToEmployeeName']==null?"":json['ReportToEmployeeName'];
    fixedSalary = json['FixedSalary']==null?0.00:json['FixedSalary'];
    fixedBasic = json['FixedBasic']==null?0.00:json['FixedBasic'];
    fixedHRA = json['FixedHRA']==null?0.00:json['FixedHRA'];
    fixedConv = json['FixedConv']==null?0.00:json['FixedConv'];
    fixedDA = json['FixedDA']==null?0.00:json['FixedDA'];
    fixedSpecial = json['FixedSpecial']==null?0.00:json['FixedSpecial'];
    birthDate = json['BirthDate']==null?"":json['BirthDate'];
    confirmationDate = json['ConfirmationDate']==null?"":json['ConfirmationDate'];
    joinDate = json['JoinDate']==null?"":json['JoinDate'];
    releaseDate = json['ReleaseDate']==null?"":json['ReleaseDate'];
    authorizedSign = json['AuthorizedSign']==null?"":json['AuthorizedSign'];
    drivingLicenseNo = json['DrivingLicenseNo']==null?"":json['DrivingLicenseNo'];
    passportNo = json['PassportNo']==null?"":json['PassportNo'];
    aadharCardNo = json['AadharCardNo']==null?"":json['AadharCardNo'];
    pANCardNo = json['PANCardNo']==null?"":json['PANCardNo'];
    pFCalculation = json['PF_Calculation']==null?false:json['PF_Calculation'];
    pTCalculation = json['PT_Calculation']==null?false:json['PT_Calculation'];
    eSICalculation = json['ESI_Calculation']==null?0:json['ESI_Calculation'];
    eSignaturePath = json['eSignaturePath']==null?"":json['eSignaturePath'];
    bankName = json['BankName']==null?"":json['BankName'];
    bankBranch = json['BankBranch']==null?"":json['BankBranch'];
    bankAccountNo = json['BankAccountNo']==null?"":json['BankAccountNo'];
    bankIFSC = json['BankIFSC']==null?"":json['BankIFSC'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RowNum'] = this.rowNum;
    data['pkID'] = this.pkID;
    data['EmployeeName'] = this.employeeName;
    data['CardNo'] = this.cardNo;
    data['MobileNo'] = this.mobileNo;
    data['Landline'] = this.landline;
    data['EmailAddress'] = this.emailAddress;
    data['EmailPassword'] = this.emailPassword;
    data['Gender'] = this.gender;
    data['WorkingHours'] = this.workingHours;
    data['ShiftCode'] = this.shiftCode;
    data['ShiftName'] = this.shiftName;
    data['BasicPer'] = this.basicPer;
    data['DesigCode'] = this.desigCode;
    data['Designation'] = this.designation;
    data['EmployeeImage'] = this.employeeImage;
    data['OrgCode'] = this.orgCode;
    data['OrgName'] = this.orgName;
    data['EmpCode'] = this.empCode;
    data['ReportTo'] = this.reportTo;
    data['ReportToEmployeeName'] = this.reportToEmployeeName;
    data['FixedSalary'] = this.fixedSalary;
    data['FixedBasic'] = this.fixedBasic;
    data['FixedHRA'] = this.fixedHRA;
    data['FixedConv'] = this.fixedConv;
    data['FixedDA'] = this.fixedDA;
    data['FixedSpecial'] = this.fixedSpecial;
    data['BirthDate'] = this.birthDate;
    data['ConfirmationDate'] = this.confirmationDate;
    data['JoinDate'] = this.joinDate;
    data['ReleaseDate'] = this.releaseDate;
    data['AuthorizedSign'] = this.authorizedSign;
    data['DrivingLicenseNo'] = this.drivingLicenseNo;
    data['PassportNo'] = this.passportNo;
    data['AadharCardNo'] = this.aadharCardNo;
    data['PANCardNo'] = this.pANCardNo;
    data['PF_Calculation'] = this.pFCalculation;
    data['PT_Calculation'] = this.pTCalculation;
    data['ESI_Calculation'] = this.eSICalculation;
    data['eSignaturePath'] = this.eSignaturePath;
    data['BankName'] = this.bankName;
    data['BankBranch'] = this.bankBranch;
    data['BankAccountNo'] = this.bankAccountNo;
    data['BankIFSC'] = this.bankIFSC;
    return data;
  }
}