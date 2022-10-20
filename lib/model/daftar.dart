class Kontak{
  int? id;
  String? Nama;
  String? notelp;
  String? Peminjaman;
  String? Pengembalian;
  String? Jaminan;

  Kontak({this.id, this.Nama, this.notelp, this.Peminjaman, this.Pengembalian, this.Jaminan});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['nama'] = Nama;
    map['notelp'] = notelp;
    map['Tanggal_Peminjaman'] = Peminjaman;
    map['tanggal_pengembalian'] = Pengembalian;
    map['jaminan'] = Jaminan;
    
    return map;
  }

  Kontak.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.Nama = map['nama'];
    this.notelp = map['notelp'];
    this.Peminjaman = map['Tanggal_Peminjaman'];
    this.Pengembalian = map['tanggal_pengembalian'];
    this.Jaminan = map['jaminan'];
  }
}