class GroupModel {
  String? arrive;
  String? depart;
  String? membre;
  String? prix;


  GroupModel(
      {this.arrive,
        this.depart,
        this.membre,
      });

  GroupModel.formJson(Map<String, dynamic> json) {
    arrive = json['arrivé'];
    depart = json['depart'];
    membre = json['membre'];
    prix = json['prix'];
  }
}