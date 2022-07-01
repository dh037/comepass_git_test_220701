
class Voucher {
  String? shopName;

  Voucher({this.shopName});

  Voucher.fromJson(Map<String, dynamic> json) {
    shopName = json['shop_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shop_name'] = this.shopName;
    return data;
  }

}

