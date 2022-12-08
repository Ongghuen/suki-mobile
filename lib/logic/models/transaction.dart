class TransactionModel {
  Transaction? ongoing;
  List<Transaction>? orders;
  List<Transaction>? customs;

  TransactionModel({this.ongoing, this.orders, this.customs});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    ongoing =
    json['ongoing'] != null ? new Transaction.fromJson(json['ongoing']) : null;
    if (json['orders'] != null) {
      orders = <Transaction>[];
      json['orders'].forEach((v) {
        orders!.add(new Transaction.fromJson(v));
      });
    }
    if (json['customs'] != null) {
      customs = <Transaction>[];
      json['customs'].forEach((v) {
        customs!.add(new Transaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ongoing != null) {
      data['ongoing'] = this.ongoing!.toJson();
    }
    if (this.orders != null) {
      data['orders'] = this.orders!.map((v) => v.toJson()).toList();
    }
    if (this.customs != null) {
      data['customs'] = this.customs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transaction {
  int? id;
  String? status;
  int? userId;
  String? buktiBayar;
  int? totalHarga;
  String? tglTransaksi;
  String? tglSelesai;
  String? categories;
  String? createdAt;
  String? updatedAt;

  Transaction(
      {this.id,
        this.status,
        this.userId,
        this.buktiBayar,
        this.totalHarga,
        this.tglTransaksi,
        this.tglSelesai,
        this.categories,
        this.createdAt,
        this.updatedAt});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    userId = json['user_id'];
    buktiBayar = json['bukti_bayar'];
    totalHarga = json['total_harga'];
    tglTransaksi = json['tgl_transaksi'];
    tglSelesai = json['tgl_selesai'];
    categories = json['categories'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['bukti_bayar'] = this.buktiBayar;
    data['total_harga'] = this.totalHarga;
    data['tgl_transaksi'] = this.tglTransaksi;
    data['tgl_selesai'] = this.tglSelesai;
    data['categories'] = this.categories;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
