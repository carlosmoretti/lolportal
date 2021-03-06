class ItensDto {
  String name;
  String description;
  String colloq;
  String plaintext;
  List<String> into;
  Image image;
  Gold gold;
  List<String> tags;
  Maps maps;
  Stats stats;

  ItensDto(
      {this.name,
      this.description,
      this.colloq,
      this.plaintext,
      this.into,
      this.image,
      this.gold,
      this.tags,
      this.maps,
      this.stats});

  ItensDto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    colloq = json['colloq'];
    plaintext = json['plaintext'];
    into = json['into'].cast<String>();
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    gold = json['gold'] != null ? new Gold.fromJson(json['gold']) : null;
    tags = json['tags'].cast<String>();
    maps = json['maps'] != null ? new Maps.fromJson(json['maps']) : null;
    stats = json['stats'] != null ? new Stats.fromJson(json['stats']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['colloq'] = this.colloq;
    data['plaintext'] = this.plaintext;
    data['into'] = this.into;
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    if (this.gold != null) {
      data['gold'] = this.gold.toJson();
    }
    data['tags'] = this.tags;
    if (this.maps != null) {
      data['maps'] = this.maps.toJson();
    }
    if (this.stats != null) {
      data['stats'] = this.stats.toJson();
    }
    return data;
  }
}

class Image {
  String full;
  String sprite;
  String group;
  int x;
  int y;
  int w;
  int h;

  Image({this.full, this.sprite, this.group, this.x, this.y, this.w, this.h});

  Image.fromJson(Map<String, dynamic> json) {
    full = json['full'];
    sprite = json['sprite'];
    group = json['group'];
    x = json['x'];
    y = json['y'];
    w = json['w'];
    h = json['h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full'] = this.full;
    data['sprite'] = this.sprite;
    data['group'] = this.group;
    data['x'] = this.x;
    data['y'] = this.y;
    data['w'] = this.w;
    data['h'] = this.h;
    return data;
  }
}

class Gold {
  int base;
  bool purchasable;
  int total;
  int sell;

  Gold({this.base, this.purchasable, this.total, this.sell});

  Gold.fromJson(Map<String, dynamic> json) {
    base = json['base'];
    purchasable = json['purchasable'];
    total = json['total'];
    sell = json['sell'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base'] = this.base;
    data['purchasable'] = this.purchasable;
    data['total'] = this.total;
    data['sell'] = this.sell;
    return data;
  }
}

class Maps {
  bool b11;
  bool b12;
  bool b21;
  bool b22;

  Maps({this.b11, this.b12, this.b21, this.b22});

  Maps.fromJson(Map<String, dynamic> json) {
    b11 = json['11'];
    b12 = json['12'];
    b21 = json['21'];
    b22 = json['22'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['11'] = this.b11;
    data['12'] = this.b12;
    data['21'] = this.b21;
    data['22'] = this.b22;
    return data;
  }
}

class Stats {
  int flatMovementSpeedMod;

  Stats({this.flatMovementSpeedMod});

  Stats.fromJson(Map<String, dynamic> json) {
    flatMovementSpeedMod = json['FlatMovementSpeedMod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FlatMovementSpeedMod'] = this.flatMovementSpeedMod;
    return data;
  }
}