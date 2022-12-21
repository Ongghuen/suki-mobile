class DetailTransactionCustomModel {
  List<Details>? details;

  DetailTransactionCustomModel({this.details});

  DetailTransactionCustomModel.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
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
  List<Customs>? customs;

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
        this.customs});

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
    if (json['customs'] != null) {
      customs = <Customs>[];
      json['customs'].forEach((v) {
        customs!.add(new Customs.fromJson(v));
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
    if (this.customs != null) {
      data['customs'] = this.customs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customs {
  int? id;
  int? transactionId;
  String? name;
  String? status;
  String? jenisCustom;
  String? bahan;
  String? desc;
  int? dp;
  String? createdAt;
  String? updatedAt;

  Customs(
      {this.id,
        this.transactionId,
        this.name,
        this.status,
        this.jenisCustom,
        this.bahan,
        this.desc,
        this.dp,
        this.createdAt,
        this.updatedAt});

  Customs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionId = json['transaction_id'];
    name = json['name'];
    status = json['status'];
    jenisCustom = json['jenis_custom'];
    bahan = json['bahan'];
    desc = json['desc'];
    dp = json['dp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transaction_id'] = this.transactionId;
    data['name'] = this.name;
    data['status'] = this.status;
    data['jenis_custom'] = this.jenisCustom;
    data['bahan'] = this.bahan;
    data['desc'] = this.desc;
    data['dp'] = this.dp;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
