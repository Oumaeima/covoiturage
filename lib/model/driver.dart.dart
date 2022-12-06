class DriverModel {
  String? name;
  String? birthday;
  String? email;
  String? image;
  String? marqueVoiture;
  String? numPermis;
  String? photoVoiture;
  String? plaqueImmatriculation;
  String? rectoPermis;
  String? versoPermis;
  String? expirationPermis;

  DriverModel(
      {this.name,
        this.birthday,
        this.email,
        this.image,
        this.marqueVoiture,
        this.numPermis,
        this.photoVoiture,
        this.plaqueImmatriculation,
        this.rectoPermis,
        this.versoPermis,
        this.expirationPermis});

  DriverModel.formJson(Map<String, dynamic> json){
    name = json['name'];
    birthday = json['birthday'];
    email = json['email'];
    image = json['image'];
    marqueVoiture = json['marque-voiture'];
    plaqueImmatriculation = json['plaque-immatriculation'];
    numPermis = json['num-permis'];
    rectoPermis = json['recto-permis'];
    versoPermis = json['verso-permis'];
    expirationPermis = json['expiration-permis'];
    photoVoiture = json['photo-voiture'];
  }
}