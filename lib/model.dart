class CustomerData {
  final String customerID;
  final String reservationID;
  final String address;
  final String contactNo;
  final String firstName;
  final String lastName;

  const CustomerData({
    required this.customerID,
    required this.reservationID,
    required this.address,
    required this.contactNo,
    required this.firstName,
    required this.lastName
  });

  factory CustomerData.fromJSON(Map<String, dynamic> json) {
    return CustomerData(
      customerID: json["customer_id"],
      reservationID: json["reservation_id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      address: json["address"],
      contactNo: json["contact_no"]
    );
  }
}






class ReservationData {
  final String reservationID;
  final String staffID;
  final String customerID;
  final int carIdx;
  final num totalCharge;
  final num dailyTotal;
  final String reservedFrom;
  final String reservedTo;
  final String lastModified;

  const ReservationData({
    required this.reservationID,
    required this.staffID,
    required this.customerID,
    required this.carIdx,
    required this.totalCharge,
    required this.dailyTotal,
    required this.reservedFrom,
    required this.reservedTo,
    required this.lastModified
  });

  factory ReservationData.fromJSON(Map<String, dynamic> json) {
    return ReservationData(
      reservationID: json["reservation_id"],
      staffID: json["staff_id"],
      customerID: json["customer_id"],
      carIdx: json["car_idx"],
      totalCharge: json["total_charge"],
      dailyTotal: json["daily_total"],
      reservedFrom: json["reserved_from"],
      reservedTo: json["reserved_to"],
      lastModified: json["last_modified"]
    );
  }
}

