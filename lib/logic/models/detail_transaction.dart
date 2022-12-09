class DetailTransactionModel {
  List<Results>? results;

  DetailTransactionModel({this.results});

  DetailTransactionModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  int? id;
  String? image;
  String? name;
  String? desc;
  int? harga;
  int? qty;
  String? categories;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Results(
      {this.id,
      this.image,
      this.name,
      this.desc,
      this.harga,
      this.qty,
      this.categories,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    desc = json['desc'];
    harga = json['harga'];
    qty = json['qty'];
    categories = json['categories'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['harga'] = this.harga;
    data['qty'] = this.qty;
    data['categories'] = this.categories;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? transactionId;
  int? productId;
  int? qty;
  int? subTotal;

  Pivot({this.transactionId, this.productId, this.qty, this.subTotal});

  Pivot.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    productId = json['product_id'];
    qty = json['qty'];
    subTotal = json['sub_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_id'] = this.transactionId;
    data['product_id'] = this.productId;
    data['qty'] = this.qty;
    data['sub_total'] = this.subTotal;
    return data;
  }
}
