import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class LogProject extends Equatable {
  String? status;
  String? catatan;
  String? dokumen;
  Timestamp? tanggalLog;

  LogProject({
    this.status,
    this.catatan,
    this.dokumen,
    this.tanggalLog,
  });

  LogProject.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    catatan = json['catatan'];
    dokumen = json['dokumen'];
    tanggalLog = json['tanggalLog'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['catatan'] = catatan;
    data['dokumen'] = dokumen;
    data['tanggalLog'] = tanggalLog;
    return data;
  }

  @override
  List<Object?> get props => [
        status,
        catatan,
        dokumen,
        tanggalLog,
      ];
}
