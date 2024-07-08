class Product {
  String id;
  String nama;
  num price;
  num qty;
  String attr;
  num weight;
  


  Product({
    required this.id,
    required this.nama,
    required this.price,
    required this.qty,
    required this.attr,
    required this.weight,
    
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      nama: json['name'],
      price: json['price'],
      qty: json['qty'],
      attr: json['attr'],
      weight: json['weight'],
    );
  }
}


// List<Product> dataProduct = [
//   Product(
//       id: '1',
//       nama: 'Juice Mangga',
//       price: 8000,
//       qty: 20,
//       attr: "pcs", 
//       weight: 200, 
//       image: 'images/product1.png'
//       ),
//   Product(
//       id: '2',
//       nama: 'Juice Jeruk',
//       price: 8000,
//       qty: 10,
//       attr: "pcs", 
//       weight: 200, 
//       image: 'images/product2.png'
//       ),
//   Product(
//       id: '3',
//       nama: 'Juice jambu',
//       price: 7000,
//       qty: 7,
//       attr: "pcs", 
//       weight: 200, 
//       image: 'images/product3.png'
//       ),
//   Product(
//       id: '4',
//       nama: 'Juice nanas',
//       price: 9000,
//       qty: 10,
//       attr: "pcs", 
//       weight: 200, 
//       image: 'images/product4.png'
//       ),

// ];
