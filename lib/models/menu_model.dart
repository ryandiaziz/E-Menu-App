class Menu {
  String id;
  final String nama;
  final int harga;
  String imageUrl;
  final String kategori;
  final String idResto;
  double? rating;
  int? sumRating;
  int? countRating;

  Menu({
    this.id = '',
    required this.nama,
    required this.harga,
    required this.kategori,
    this.imageUrl = '',
    required this.idResto,
    this.rating,
    this.sumRating,
    this.countRating,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'harga': harga,
        'kategori': kategori,
        'imageUrl': imageUrl,
        'idResto': idResto,
        'rating': 0.0,
        'sumRating': 0,
        'countRating': 0,
      };
  static Menu fromJson(Map<String, dynamic> json) => Menu(
        id: json['id'],
        nama: json['nama'],
        harga: json['harga'],
        kategori: json['kategori'],
        imageUrl: json['imageUrl'],
        idResto: json['idResto'],
      );
}
