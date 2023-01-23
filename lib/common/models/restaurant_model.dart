class Restaurant {
  String id;
  final String name;
  final String alamat;
  String imageUrl;
  final String idUser;

  Restaurant({
    this.id = '',
    required this.name,
    required this.alamat,
    this.imageUrl = '',
    required this.idUser,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'alamat': alamat,
        'imageUrl': imageUrl,
        'idUser': idUser,
      };
  static Restaurant fromJson(Map<String, dynamic> json) => Restaurant(
        id: json['id'],
        name: json['name'],
        alamat: json['alamat'],
        imageUrl: json['imageUrl'],
        idUser: json['idUser'],
      );
}
