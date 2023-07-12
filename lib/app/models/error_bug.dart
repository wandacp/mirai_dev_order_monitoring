import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ErrorBug extends Equatable {
  String? id;
  String? uidCustomer;
  String? idProject;
  String? prioritas;
  String? status;
  String? deskripsi;
  String? dokumen;
  Timestamp? tanggal;

  ErrorBug({
    this.id,
    this.uidCustomer,
    this.idProject,
    this.prioritas,
    this.status,
    this.deskripsi,
    this.dokumen,
    this.tanggal,
  });

  ErrorBug.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uidCustomer = json['uidCustomer'];
    idProject = json['idProject'];
    prioritas = json['prioritas'];
    status = json['status'];
    deskripsi = json['deskripsi'];
    dokumen = json['dokumen'];
    tanggal = json['tanggal'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['uidCustomer'] = uidCustomer;
    data['idProject'] = idProject;
    data['prioritas'] = prioritas;
    data['status'] = status;
    data['deskripsi'] = deskripsi;
    data['dokumen'] = dokumen;
    data['tanggal'] = tanggal;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        uidCustomer,
        idProject,
        prioritas,
        status,
        deskripsi,
        dokumen,
        tanggal,
      ];
}
