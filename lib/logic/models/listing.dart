class ListingModel {
  List<Results>? results;
  String? msg;

  ListingModel({this.results, this.msg});

  ListingModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class Results {
  int? id;
  String? title;
  String? tags;
  String? company;
  String? location;
  String? email;
  String? website;
  String? description;
  String? createdAt;
  String? updatedAt;

  Results(
      {this.id,
      this.title,
      this.tags,
      this.company,
      this.location,
      this.email,
      this.website,
      this.description,
      this.createdAt,
      this.updatedAt});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    tags = json['tags'];
    company = json['company'];
    location = json['location'];
    email = json['email'];
    website = json['website'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['tags'] = this.tags;
    data['company'] = this.company;
    data['location'] = this.location;
    data['email'] = this.email;
    data['website'] = this.website;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
