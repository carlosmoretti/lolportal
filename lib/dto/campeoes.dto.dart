class CampeoesDto {
  String id;
  String key;
  String name;
  
  String imagem;

  CampeoesDto({this.id, this.key, this.name});

  CampeoesDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['key'] = this.key;
    data['id'] = this.id;
    return data;
  }
}