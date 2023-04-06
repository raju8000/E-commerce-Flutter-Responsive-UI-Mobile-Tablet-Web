class ModelPaymentCard {
  String? cardNo = "3434 3434 3434";
  String? month = "01";
  String? year = "2021";
  String? cvv = "123";
  String? holderName = "John";

  ModelPaymentCard({this.cardNo,this.month,this.year,this.cvv,this.holderName});

  Map<String,String> toJson(){
    final Map<String, String> data = <String, String>{};
    data['card_no'] = cardNo!;
    data['month'] = month!;
    data['year'] = year!;
    data['cvv'] = cvv!;
    data['holder_name'] = holderName!;
    return data;
  }

  ModelPaymentCard.fromJson(Map<String, dynamic> json) {
    print("inside");
    if(json.isEmpty){
      return;
    }
    ModelPaymentCard(
      cardNo: json['card_no'],
      month: json['month'],
      year: json['year'],
      cvv: json['cvv'],
      holderName: json['holder_name'],
    );
  }
}
