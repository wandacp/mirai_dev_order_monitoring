import 'package:equatable/equatable.dart';

class UserApp extends Equatable {
  String? uid;
  String? nama;
  String? nomorHP;
  String? email;
  String? roleUser;

  UserApp({
    this.uid,
    this.nama,
    this.nomorHP,
    this.email,
    this.roleUser,
  });

  UserApp.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    nama = json['nama'];
    nomorHP = json['nomorHP'];
    email = json['email'];
    roleUser = json['roleUser'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['nama'] = nama;
    data['nomorHP'] = nomorHP;
    data['email'] = email;
    data['roleUser'] = roleUser;
    return data;
  }

  @override
  List<Object?> get props => [
        uid,
        nama,
        nomorHP,
        email,
        roleUser,
      ];
}
