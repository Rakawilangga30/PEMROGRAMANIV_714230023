class ContactsModel {
  final String id;
  final String namaKontak;
  final String nomorHp;

  ContactsModel({
    required this.id,
    required this.namaKontak,
    required this.nomorHp,
  });

  factory ContactsModel.fromJson(Map<String, dynamic> json) {
    return ContactsModel(
      id: json['_id'] ?? '',
      namaKontak: json['nama_kontak'] ?? '',
      nomorHp: json['nomor_hp'] ?? '',
    );
  }
}

class ContactInput {
  final String namaKontak;
  final String nomorHp;

  ContactInput({
    required this.namaKontak,
    required this.nomorHp,
  });

  Map<String, dynamic> toJson() => {
        'nama_kontak': namaKontak,
        'nomor_hp': nomorHp,
      };
}

class ContactResponse {
  final String? insertedId;
  final String message;
  final int status;

  ContactResponse({
    this.insertedId,
    required this.message,
    required this.status,
  });

  factory ContactResponse.fromJson(Map<String, dynamic> json) {
    return ContactResponse(
      insertedId: json['inserted_id'],
      message: json['message'] ?? '',
      status: json['status'] ?? 0,
    );
  }
}