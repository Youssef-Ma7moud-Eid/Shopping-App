class Amount {
    const Amount({this.total, this.currency, this.details});

  final String? total;
  final String? currency;
  final Details? details;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['total'] = total;
    data['currency'] = currency;
    if (details != null) {
      data['details'] = details!.toJson();
    }
    return data;
  }
}

class Details {
  String? subtotal;
  String? shipping;
  int? shippingDiscount;

  Details({this.subtotal, this.shipping, this.shippingDiscount});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['subtotal'] = subtotal;
    data['shipping'] = shipping;
    data['shipping_discount'] = shippingDiscount;
    return data;
  }
}

class ItemList {
  List<Items>? items;

  ItemList({this.items});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? name;
  int? quantity;
  String? price;
  String? currency;

  Items({this.name, this.quantity, this.price, this.currency});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['quantity'] = quantity;
    data['price'] = price;
    data['currency'] = currency;
    return data;
  }
}
