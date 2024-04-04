class MasterReportModel{
  String state;
  String mandalam;
  String district;
  String id;
  String name;
  String accessType;
  int count;
  String typeofReg;
  String paymentStatus;
  String unit;
  String requestStatus;
  MasterReportModel(this.id,this.name,this.accessType,this.state,this.mandalam,this.district,this.count,this.typeofReg,this.paymentStatus,this.unit,this.requestStatus);
}

class DistrictFilterModel{
  String name;
  int value;
  DistrictFilterModel(this.name,this.value);
}

class masterCordinatorModel{
  String id;
  String addedBy;
  String dateMillis;
  DateTime addedTime;
  String address;
  String designation;
  String name;
  String phone;
  String photo;
  String state;
  String district;
  String assembly;
  String unit;
  int count;
  masterCordinatorModel(this.id,this.addedBy,this.dateMillis,this.addedTime,this.address,this.designation,this.name,this.phone,this.photo,
  this.state,this.district,this.assembly,this.unit,this.count);

}

