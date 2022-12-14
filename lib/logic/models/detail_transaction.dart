class DetailTransactionModel {
  List<Results>? results;
  List<Details>? details;

  DetailTransactionModel({this.results, this.details});

  DetailTransactionModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }

    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }

    if (this.results != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Details {
  int? id;
  String? status;
  int? userId;
  String? buktiBayar;
  String? alamat;
  int? totalHarga;
  String? tglTransaksi;
  String? tglSelesai;
  String? categories;
  String? createdAt;
  String? updatedAt;
  List<Results>? products;

  Details(
      {this.id,
        this.status,
        this.userId,
        this.buktiBayar,
        this.alamat,
        this.totalHarga,
        this.tglTransaksi,
        this.tglSelesai,
        this.categories,
        this.createdAt,
        this.updatedAt,
        this.products});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    userId = json['user_id'];
    buktiBayar = json['bukti_bayar'];
    alamat = json['alamat'];
    totalHarga = json['total_harga'];
    tglTransaksi = json['tgl_transaksi'];
    tglSelesai = json['tgl_selesai'];
    categories = json['categories'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['products'] != null) {
      products = <Results>[];
      json['products'].forEach((v) {
        products!.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['bukti_bayar'] = this.buktiBayar;
    data['alamat'] = this.alamat;
    data['total_harga'] = this.totalHarga;
    data['tgl_transaksi'] = this.tglTransaksi;
    data['tgl_selesai'] = this.tglSelesai;
    data['categories'] = this.categories;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
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
