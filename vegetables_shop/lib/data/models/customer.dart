import 'dart:convert';

Customer customerFromJson(String str) {
  final jsonData = json.decode(str);
  return Customer.fromSql(jsonData);
}

String customerToJson(Customer data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Customer {
  int customerId;
  String customerSurname;
  String customerName;
  String phoneNumber;
  String emailAddress;
  int addressId;
  String photoUrl;
  String password;
  int paymentCardId;

  Customer(
      this.customerId,
      this.customerSurname,
      this.customerName,
      this.phoneNumber,
      this.emailAddress,
      this.addressId,
      this.photoUrl,
      this.password,
      this.paymentCardId);

  Customer.fromPost(
      this.customerSurname,
      this.customerName,
      this.phoneNumber,
      this.emailAddress,
      this.addressId,
      this.photoUrl,
      this.password,
      this.paymentCardId);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'customer_surname': customerSurname,
      'customer_name': customerName,
      'phone_number': phoneNumber,
      'email': emailAddress,
      'address_id': addressId,
      'photo': photoUrl,
      'password': password,
      'payment_card_id': paymentCardId,
    };
    if (customerId != null) {
      map['customer_id'] = customerId;
    }
    return map;
  }

  factory Customer.fromSql(dynamic sql) => Customer(
      sql['customer_id'],
      sql['customer_surname'],
      sql['customer_name'],
      sql['phone_number'],
      sql['email'],
      sql['address_id'],
      sql['photo'],
      sql['password'],
      sql['payment_card_id']);
}

class Address {
  int addressId;
  String addressName;
  int postcode;
  String country;
  String city;

  Address(
      this.addressId, this.addressName, this.postcode, this.country, this.city);

  Address.fromPost(this.addressName, this.postcode, this.country, this.city);

  factory Address.fromSql(dynamic sql) => Address(sql['address_id'],
      sql['address_name'], sql['postcode'], sql['country'], sql['city']);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'address_name': addressName,
      'postcode': postcode,
      'country': country,
      'city': city
    };

    if (addressId != null) {
      map['address_id'] = addressId;
    }
    return map;
  }
}

class PaymentCard {
  int paymentCardId;
  String paymentCardNumber;
  String expireDate;
  String cvc;
  String paymentCardHolder;

  PaymentCard(this.paymentCardId, this.paymentCardNumber, this.expireDate,
      this.cvc, this.paymentCardHolder);

  PaymentCard.fromPost(this.paymentCardNumber, this.expireDate, this.cvc,
      this.paymentCardHolder);

  factory PaymentCard.fromSql(dynamic sql) => PaymentCard(
      sql['payment_card_id'],
      sql['payment_card_number'],
      sql['expire_date'],
      sql['cvc'],
      sql['payment_card_holder']);

  Map<String, dynamic> toMap() {
    var map =  <String, dynamic>{
      'payment_card_number': paymentCardNumber,
      'expire_date': expireDate,
      'cvc': cvc,
      'payment_card_holder': paymentCardHolder,
    };

    if(paymentCardId != null){
      map['payment_card_id'] = paymentCardId;
    }

    return map;
  }
}
