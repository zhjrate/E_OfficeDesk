/*SenderName
SenderMail
QueryDatetime
CompanyName
CountryFlagURL
Message
Address
City
State
CountryISO
ForProduct
PrimaryMobileNo
SecondaryMobileNo
LeadSource
ACID
CompanyId
*/

class NewTeleCallerSaveRequest {
  String LeadID;
  String SenderName;
  String QueryDatetime;
  String SenderMail;
  String CompanyName;
  String CountryFlagURL;
  String Message;
  String Address;
  String City;
  String State;
  String Country;
  String CountryISO;
  String PrimaryMobileNo;
  String SecondaryMobileNo;
  String ForProduct;
  String LeadSource;
  String LeadStatus;
  String EmployeeID;
  String ACID;
  String ProductID;
  String Pincode;
  String StateCode;
  String CityCode;
  String CountryCode;
  String CustomerID;
  String ExLeadClosure;
  String LoginUserID;
  String FollowupNotes;
  String FollowupDate;
  String PreferredTime;
  String SerialKey;
  String DisqualifedRemarks;
  String CompanyId;
  String Thickness;
  String Quantity;
  String Area;
  String NetAmt;
  String RefNo;
  String GlassName;
  String PrintRate;
  String Rate;
  String Latitude;
  String Longitude;

  NewTeleCallerSaveRequest(
      {this.LeadID,
      this.SenderName,
      this.QueryDatetime,
      this.SenderMail,
      this.CompanyName,
      this.CountryFlagURL,
      this.Message,
      this.Address,
      this.City,
      this.State,
      this.Country,
      this.CountryISO,
      this.PrimaryMobileNo,
      this.SecondaryMobileNo,
      this.ForProduct,
      this.LeadSource,
      this.LeadStatus,
      this.EmployeeID,
      this.ACID,
      this.ProductID,
      this.Pincode,
      this.StateCode,
      this.CityCode,
      this.CountryCode,
      this.CustomerID,
      this.ExLeadClosure,
      this.LoginUserID,
      this.FollowupNotes,
      this.FollowupDate,
      this.PreferredTime,
      this.SerialKey,
      this.DisqualifedRemarks,
      this.CompanyId,
      this.Thickness,
      this.Quantity,
      this.Area,
      this.NetAmt,
      this.RefNo,
      this.GlassName,
      this.PrintRate,
      this.Rate,
      this.Latitude,
      this.Longitude});

  NewTeleCallerSaveRequest.fromJson(Map<String, dynamic> json) {
    LeadID = json['LeadID'];
    SenderName = json['SenderName'];
    QueryDatetime = json['QueryDatetime'];
    SenderMail = json['SenderMail'];
    CompanyName = json['CompanyName'];
    CountryFlagURL = json['CountryFlagURL'];
    Message = json['Message'];
    Address = json['Address'];
    City = json['City'];
    State = json['State'];
    Country = json['Country'];
    CountryISO = json['CountryISO'];
    PrimaryMobileNo = json['PrimaryMobileNo'];
    SecondaryMobileNo = json['SecondaryMobileNo'];
    ForProduct = json['ForProduct'];
    LeadSource = json['LeadSource'];
    LeadStatus = json['LeadStatus'];
    EmployeeID = json['EmployeeID'];
    ACID = json['ACID'];
    ProductID = json['ProductID'];
    Pincode = json['Pincode'];
    StateCode = json['StateCode'];
    CityCode = json['CityCode'];
    CountryCode = json['CountryCode'];
    CustomerID = json['CustomerID'];
    ExLeadClosure = json['ExLeadClosure'];
    LoginUserID = json['LoginUserID'];
    FollowupNotes = json['FollowupNotes'];
    FollowupDate = json['FollowupDate'];
    PreferredTime = json['PreferredTime'];
    SerialKey = json['SerialKey'];
    DisqualifedRemarks = json['DisqualifedRemarks'];
    CompanyId = json['CompanyId'];
    Thickness = json['Thickness'];
    Quantity = json['Quantity'];
    Area = json['Area'];
    NetAmt = json['NetAmt'];
    RefNo = json['RefNo'];
    GlassName = json['GlassName'];
    PrintRate = json['PrintRate'];
    Rate = json['Rate'];
    Latitude = json['Latitude'];
    Longitude = json['Longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['LeadID'] = this.LeadID;
    data['SenderName'] = this.SenderName;
    data['QueryDatetime'] = this.QueryDatetime;
    data['SenderMail'] = this.SenderMail;
    data['CompanyName'] = this.CompanyName;
    data['CountryFlagURL'] = this.CountryFlagURL;
    data['Message'] = this.Message;
    data['Address'] = this.Address;
    data['City'] = this.City;
    data['State'] = this.State;
    data['Country'] = "India";
    data['CountryISO'] = this.CountryISO;
    data['PrimaryMobileNo'] = this.PrimaryMobileNo;
    data['SecondaryMobileNo'] = this.SecondaryMobileNo;
    data['ForProduct'] = this.ForProduct;
    data['LeadSource'] = this.LeadSource;
    data['LeadStatus'] = this.LeadStatus;
    data['EmployeeID'] = this.EmployeeID;
    data['ACID'] = this.ACID;
    data['ProductID'] = this.ProductID;
    data['Pincode'] = this.Pincode;
    data['StateCode'] = this.StateCode;
    data['CityCode'] = this.CityCode;
    data['CountryCode'] = this.CountryCode;
    data['CustomerID'] = this.CustomerID;
    data['ExLeadClosure'] = this.ExLeadClosure;
    data['LoginUserID'] = this.LoginUserID;
    data['FollowupNotes'] = this.FollowupNotes;
    data['FollowupDate'] = this.FollowupDate;
    data['PreferredTime'] = this.PreferredTime;
    data['SerialKey'] = this.SerialKey;
    data['DisqualifedRemarks'] = this.DisqualifedRemarks;
    data['CompanyId'] = this.CompanyId;
    data['Thickness'] = this.Thickness;
    data['Quantity'] = this.Quantity;
    data['Area'] = this.Area;
    data['NetAmt'] = this.NetAmt;
    data['RefNo'] = this.RefNo;
    data['GlassName'] = this.GlassName;
    data['PrintRate'] = this.PrintRate;
    data['Rate'] = this.Rate;
    data['Latitude'] = this.Latitude;
    data['Longitude'] = this.Longitude;

    return data;
  }
}

/*
class NewTeleCallerSaveRequest {
  String LeadID;
  String SenderName;
  String QueryDatetime;
  String SenderMail;
  String CompanyName;
  String CountryFlagURL;
  String Message;
  String Address;
  String City;
  String State;
  String PrimaryMobileNo;
  String SecondaryMobileNo;
  String ForProduct;
  String LeadSource;
  String LeadStatus;
  String EmployeeID;
  String ProductID;
  String Pincode;
  String StateCode;
  String CityCode;
  String CustomerID;
  String ExLeadClosure;
  String LoginUserID;
  String CountryCode;
  String CompanyId;
  String Thickness;
  String TotalQty;
  String Area;

  NewTeleCallerSaveRequest({
      this.LeadID,
      this.SenderName,
      this.QueryDatetime,
      this.SenderMail,
      this.CompanyName,
      this.CountryFlagURL,
      this.Message,
      this.Address,
      this.City,
      this.State,
      this.PrimaryMobileNo,
      this.SecondaryMobileNo,
      this.ForProduct,
      this.LeadSource,
      this.LeadStatus,
      this.EmployeeID,
      this.ProductID,
      this.Pincode,
      this.StateCode,
      this.CityCode,
      this.CustomerID,
      this.ExLeadClosure,
      this.LoginUserID,
      this.CountryCode,
      this.CompanyId,
      this.Thickness,
      this.TotalQty,
      this.Area,
      this.NetAmt,
      this.RefNo,
      this.GlassName,
      this.PrintRate,
      this.Rate,
      this.DisqualifedRemarks});

  String NetAmt;
  String RefNo;
  String GlassName;
  String PrintRate;
  String Rate;
  String DisqualifedRemarks;

  NewTeleCallerSaveRequest.fromJson(Map<String, dynamic> json) {
    LeadID = json['LeadID'];
    SenderName = json['SenderName'];
    QueryDatetime = json['QueryDatetime'];
    SenderMail = json['SenderMail'];
    CompanyName = json['CompanyName'];
    CountryFlagURL = json['CountryFlagURL'];
    Message = json['Message'];
    Address = json['Address'];
    City = json['City'];
    State = json['State'];
    PrimaryMobileNo = json['PrimaryMobileNo'];
    SecondaryMobileNo = json['SecondaryMobileNo'];
    ForProduct = json['ForProduct'];
    LeadSource = json['LeadSource'];
    LeadStatus = json['LeadStatus'];
    EmployeeID = json['EmployeeID'];
    ProductID = json['ProductID'];
    Pincode = json['Pincode'];
    StateCode = json['StateCode'];
    CityCode = json['CityCode'];
    CustomerID = json['CustomerID'];
    ExLeadClosure = json['ExLeadClosure'];
    LoginUserID = json['LoginUserID'];
    CountryCode = json['CountryCode'];
    CompanyId = json['CompanyId'];
    */ /*Thickness: , Quantity: , Area: , NetAmt: , RefNo: , GlassName: , PrintRate: , Rate:*/ /*
    Thickness = json['Thickness'];
    TotalQty = json['Quantity'];
    Area = json['Area'];
    NetAmt = json['NetAmt'];
    RefNo = json['RefNo'];
    GlassName = json['GlassName'];
    PrintRate = json['PrintRate'];
    Rate = json['Rate'];
    DisqualifedRemarks = json['DisqualifedRemarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LeadID'] = this.LeadID;
    data['SenderName'] = this.SenderName;
    data['QueryDatetime'] = this.QueryDatetime;
    data['SenderMail'] = this.SenderMail;
    data['CompanyName'] = this.CompanyName;
    data['CountryFlagURL'] = this.CountryFlagURL;
    data['Message'] = this.Message;
    data['Address'] = this.Address;
    data['City'] = this.City;
    data['State'] = this.State;
    data['PrimaryMobileNo'] = this.PrimaryMobileNo;
    data['SecondaryMobileNo'] = this.SecondaryMobileNo;
    data['ForProduct'] = this.ForProduct;
    data['LeadSource'] = this.LeadSource;
    data['LeadStatus'] = this.LeadStatus;
    data['EmployeeID'] = this.EmployeeID;
    data['ProductID'] = this.ProductID;
    data['Pincode'] = this.Pincode;
    data['StateCode'] = this.StateCode;
    data['CityCode'] = this.CityCode;
    data['CustomerID'] = this.CustomerID;
    data['ExLeadClosure'] = this.ExLeadClosure;
    data['LoginUserID'] = this.LoginUserID;
    data['CountryCode'] = this.CountryCode;
    data['CompanyId'] = this.CompanyId;
    data['Thickness'] = this.Thickness;
    data['Quantity'] = this.TotalQty;
    data['Area'] = this.Area;
    data['NetAmt'] = this.NetAmt;
    data['RefNo'] = this.RefNo;
    data['GlassName'] = this.GlassName;
    data['PrintRate'] = this.PrintRate;
    data['Rate'] = this.Rate;
    data['DisqualifedRemarks'] = this.DisqualifedRemarks;

    return data;
  }
}*/
