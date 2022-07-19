class Menu {
  String id;
  final String nama;
  final String harga;
  String imageUrl;
  final String kategori;

  Menu({
    this.id = '',
    required this.nama,
    required this.harga,
    required this.kategori,
    this.imageUrl = '',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'harga': harga,
        'kategori': kategori,
        'imageUrl': imageUrl,
      };
  static Menu fromJson(Map<String, dynamic> json) => Menu(
        id: json['id'],
        nama: json['nama'],
        harga: json['harga'],
        kategori: json['kategori'],
        imageUrl: json['imageUrl'],
      );
}
