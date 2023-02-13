import 'dart:convert';

Payment paymentFromJson(String str) => Payment.fromJson(json.decode(str));

String paymentToJson(Payment data) => json.encode(data.toJson());

class Payment {
  Payment({
    required this.status,
    required this.pesan,
    required this.data,
  });

  bool status;
  String pesan;
  Data data;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        status: json["status"],
        pesan: json["pesan"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "pesan": pesan,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.id,
    required this.tiketId,
    required this.nama,
    required this.responseMidtrans,
  });

  String id;
  String tiketId;
  String nama;
  ResponseMidtrans responseMidtrans;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        tiketId: json["tiket_id"],
        nama: json["nama"],
        responseMidtrans: ResponseMidtrans.fromJson(json["response_midtrans"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tiket_id": tiketId,
        "nama": nama,
        "response_midtrans": responseMidtrans.toJson(),
      };
}

class ResponseMidtrans {
  ResponseMidtrans({
    required this.statusCode,
    required this.statusMessage,
    required this.transactionId,
    required this.orderId,
    required this.merchantId,
    required this.grossAmount,
    required this.currency,
    required this.paymentType,
    required this.transactionTime,
    required this.transactionStatus,
    required this.fraudStatus,
    required this.actions,
  });

  String statusCode;
  String statusMessage;
  String transactionId;
  String orderId;
  String merchantId;
  String grossAmount;
  String currency;
  String paymentType;
  DateTime transactionTime;
  String transactionStatus;
  String fraudStatus;
  List<Action> actions;

  factory ResponseMidtrans.fromJson(Map<String, dynamic> json) =>
      ResponseMidtrans(
        statusCode: json["status_code"],
        statusMessage: json["status_message"],
        transactionId: json["transaction_id"],
        orderId: json["order_id"],
        merchantId: json["merchant_id"],
        grossAmount: json["gross_amount"],
        currency: json["currency"],
        paymentType: json["payment_type"],
        transactionTime: DateTime.parse(json["transaction_time"]),
        transactionStatus: json["transaction_status"],
        fraudStatus: json["fraud_status"],
        actions:
            List<Action>.from(json["actions"].map((x) => Action.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status_message": statusMessage,
        "transaction_id": transactionId,
        "order_id": orderId,
        "merchant_id": merchantId,
        "gross_amount": grossAmount,
        "currency": currency,
        "payment_type": paymentType,
        "transaction_time": transactionTime.toIso8601String(),
        "transaction_status": transactionStatus,
        "fraud_status": fraudStatus,
        "actions": List<dynamic>.from(actions.map((x) => x.toJson())),
      };
}

class Action {
  Action({
    required this.name,
    required this.method,
    required this.url,
  });

  String name;
  String method;
  String url;

  factory Action.fromJson(Map<String, dynamic> json) => Action(
        name: json["name"],
        method: json["method"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "method": method,
        "url": url,
      };
}
