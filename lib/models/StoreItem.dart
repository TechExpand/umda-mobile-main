class StoreItem {
  String? item_english_name;
  String? slug;
  String? description;
  String? item_image1;
  String? item_image2;
  String? asking_price;
  String? food_class;
  String? dietary_list;
  String? measuring_unit;
  String? other_description;
  Map? seller;
  String? health_benefits;
  String? preparation_method;
  String? preservation_method;
  String? disposal_method;
  String? eat_before;
  int? id, quantity_in_stock;

  StoreItem(
      {this.food_class,
      this.asking_price,
      this.item_english_name,
      this.slug,
      this.description,
      this.item_image1,
      this.item_image2,
      this.dietary_list,
        this.seller,
      this.measuring_unit,
      this.other_description,
      this.health_benefits,
      this.preparation_method,
      this.preservation_method,
      this.disposal_method,
      this.eat_before,
      this.id,
      this.quantity_in_stock});

  // @overrasking_pricee
  // String toString() {
  //   return 'StoreItem{last_price: $last_price, food_class: $food_class, item_english_name: $item_english_name, slug: $slug, description: $description, item_image1: $item_image1, item_image2: $item_image2, asking_price: $asking_price}';
  // }

  factory StoreItem.fromJson(Map<String, dynamic> json) {
    return StoreItem(
      item_english_name: json['item_english_name'],
      slug: json['slug'],
      description: json['description'],
      item_image1: json['item_image1'],
      item_image2: json['item_image2'] != null ? json['item_image2'] : '',
      asking_price: json['asking_price'],
      food_class: json['food_class'],
      dietary_list: json['dietary_list'],
      measuring_unit: json['measuring_unit'],
      other_description: json['other_description'],
      health_benefits: json['health_benefits'],
      preparation_method: json['preparation_method'],
      preservation_method: json['preservation_method'],
      disposal_method: json['disposal_method'],
      eat_before: json['eat_before'],
      id: json['id'],
      seller: json['store'],
      quantity_in_stock: json['quantity_in_stock'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "item_english_name": this.item_english_name ?? '',
      "slug": this.slug ?? '',
      "description": this.description ?? '',
      "item_image1": this.item_image1 ?? '',
      "item_image2": this.item_image2 ?? '',
      "asking_price": this.asking_price ?? '',
      "food_class": this.food_class ?? '',
    };
  }
}
