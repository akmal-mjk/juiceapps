class Stock{
  String id;
  String nama;
  num qty;
  String attr;
  num weight;
  


  Stock({
    required this.id,
    required this.nama,
    required this.qty,
    required this.attr,
    required this.weight,
    
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: json['id'],
      nama: json['name'],
      qty: json['qty'],
      attr: json['attr'],
      weight: json['weight'],
    );
  }
}
