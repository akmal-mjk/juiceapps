class Reseler {
  String id;
  String buyer;
  String phone;
  String date;
  String status;

  Reseler({
    required this.id,
    required this.buyer,
    required this.phone,
    required this.date,
    required this.status,
  });

  factory Reseler.fromJson(Map<String, dynamic> json) {
    return Reseler(
      id: json['id'],
      buyer: json['buyer'],
      phone: json['phone'],
      date: json['date'],
      status: json['status'],
    );
  }
}
