class Menu {
  String id;
  final String nama;
  final String harga;
  String imageUrl;
  final String kategori;
  final String idResto;

  Menu({
    this.id = '',
    required this.nama,
    required this.harga,
    required this.kategori,
    this.imageUrl = '',
    required this.idResto,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'harga': harga,
        'kategori': kategori,
        'imageUrl': imageUrl,
        'idResto': idResto,
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
