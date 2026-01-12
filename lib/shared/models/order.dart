class Product {
  final String name;
  final double price;
  final int quantity;
  final double total;

  const Product({
    required this.name,
    required this.price,
    required this.quantity,
    required this.total,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 0,
      total: (json['total'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
      'total': total,
    };
  }
}

class Order {
  final String id;
  final List<Product> products;
  final String customer;
  final String phone;
  final String email;
  final String address;
  final String status;
  final String rider;
  final String riderPhone;
  final String orderTime;
  final String estimatedDelivery;
  final String paymentMethod;
  final String paymentStatus;
  final String notes;
  final String orderType;
  final double subtotal;
  final double serviceCharge;
  final double vat;
  final double deliveryCharge;
  final double total;

  const Order({
    required this.id,
    required this.products,
    required this.customer,
    required this.phone,
    required this.email,
    required this.address,
    required this.status,
    required this.rider,
    required this.riderPhone,
    required this.orderTime,
    required this.estimatedDelivery,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.notes,
    required this.orderType,
    required this.subtotal,
    required this.serviceCharge,
    required this.vat,
    required this.deliveryCharge,
    required this.total,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? '',
      products: (json['products'] as List<dynamic>?)
          ?.map((p) => Product.fromJson(p))
          .toList() ?? [],
      customer: json['customer'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      status: json['status'] ?? '',
      rider: json['rider'] ?? '',
      riderPhone: json['rider_phone'] ?? '',
      orderTime: json['order_time'] ?? '',
      estimatedDelivery: json['estimated_delivery'] ?? '',
      paymentMethod: json['payment_method'] ?? '',
      paymentStatus: json['payment_status'] ?? '',
      notes: json['notes'] ?? '',
      orderType: json['order_type'] ?? '',
      subtotal: (json['subtotal'] ?? 0).toDouble(),
      serviceCharge: (json['service_charge'] ?? 0).toDouble(),
      vat: (json['vat'] ?? 0).toDouble(),
      deliveryCharge: (json['delivery_charge'] ?? 0).toDouble(),
      total: (json['total'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'products': products.map((p) => p.toJson()).toList(),
      'customer': customer,
      'phone': phone,
      'email': email,
      'address': address,
      'status': status,
      'rider': rider,
      'rider_phone': riderPhone,
      'order_time': orderTime,
      'estimated_delivery': estimatedDelivery,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'notes': notes,
      'order_type': orderType,
      'subtotal': subtotal,
      'service_charge': serviceCharge,
      'vat': vat,
      'delivery_charge': deliveryCharge,
      'total': total,
    };
  }
}