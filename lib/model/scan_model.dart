class ScanModel {
  int? id;
  String? name;
  String? desc;
  String? image;
  String? code;

  ScanModel({
    this.id,
    this.name,
    this.desc,
    this.image,
    this.code,
  });

  ScanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    image = json['image'];
    code = json['code'];
    ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['desc'] = desc;
    data['imageUrl'] = image;
    data['code'] = code;

    return data;
  }
}
