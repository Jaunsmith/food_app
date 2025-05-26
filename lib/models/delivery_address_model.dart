class DeliveryAddressModel {
  final String recipientName;
  final String recipientPhone;
  final String recipientMail;
  final String recipientState;
  final String recipientCity;
  final String recipientStreetName;
  final String? recipientMoreInfo;

  DeliveryAddressModel({
    required this.recipientCity,
    required this.recipientMail,
    required this.recipientName,
    required this.recipientPhone,
    required this.recipientState,
    required this.recipientStreetName,
    this.recipientMoreInfo,
  });

  factory DeliveryAddressModel.fromJson(Map<String, dynamic> json) {
    return DeliveryAddressModel(
      recipientCity: json['recipientCity'],
      recipientMail: json['recipientMail'],
      recipientName: json['recipientName'],
      recipientPhone: json['recipientPhone'],
      recipientState: json['recipientState'],
      recipientStreetName: json['recipientStreetName'],
      recipientMoreInfo: json['recipientMoreInfo'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> sentData = {};
    sentData['recipientMoreInfo'] = recipientMoreInfo;
    sentData['recipientCity'] = recipientCity;
    sentData['recipientMail'] = recipientMail;
    sentData['recipientName'] = recipientName;
    sentData['recipientStreetName'] = recipientStreetName;
    sentData['recipientState'] = recipientState;
    sentData['recipientPhone'] = recipientPhone;
    return sentData;
  }
}
