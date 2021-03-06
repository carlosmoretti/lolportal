class UsuarioConfiguradoDto {
  String id;
  String accountId;
  String puuid;
  String name;
  int profileIconId;
  int revisionDate;
  int summonerLevel;

  String imageIcon;

  UsuarioConfiguradoDto(
      {this.id,
      this.accountId,
      this.puuid,
      this.name,
      this.profileIconId,
      this.revisionDate,
      this.summonerLevel});

  UsuarioConfiguradoDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['accountId'];
    puuid = json['puuid'];
    name = json['name'];
    profileIconId = json['profileIconId'];
    revisionDate = json['revisionDate'];
    summonerLevel = json['summonerLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['accountId'] = this.accountId;
    data['puuid'] = this.puuid;
    data['name'] = this.name;
    data['profileIconId'] = this.profileIconId;
    data['revisionDate'] = this.revisionDate;
    data['summonerLevel'] = this.summonerLevel;
    return data;
  }
}