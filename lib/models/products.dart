class ProductModel {
  String? id;
  String? equipment;
  String? quantity;
  String? price_day;

  ProductModel({
    this.id,
    this.equipment,
    this.quantity,
    this.price_day,
});

  ProductModel.fromMap(Map<String, dynamic> data){
    id = data[id];
    equipment = data[equipment];
    quantity = data[quantity];
    price_day = data[price_day];
  }
}
