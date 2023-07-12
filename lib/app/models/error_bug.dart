import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ErrorBug extends Equatable {
  String? id;
  String? uidCustomer;
  String? idProject;
  String? prioritas;
  String? status;
  String? catatan;
  String? dokumen;
  Timestamp? tanggal;

  ErrorBug({
    this.id,
    this.uidCustomer,
    this.idProject,
    this.prioritas,
    this.status,
    this.catatan,
    this.dokumen,
    this.tanggal,
  });

  ErrorBug.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uidCustomer = json['uidCustomer'];
    idProject = json['idProject'];
    prioritas = json['prioritas'];
    status = json['status'];
    catatan = json['catatan'];
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
    data['catatan'] = catatan;
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
        catatan,
        dokumen,
        tanggal,
      ];
}
