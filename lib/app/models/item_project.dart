import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:mirai_dev_order_monitoring/app/models/log_project.dart';

class ItemProject extends Equatable {
  String? id;
  String? uidCustomer;
  String? namaProject;
  String? deskripsiProject;
  Timestamp? tanggalCreated;
  Timestamp? tanggalUpdated;
  bool? isAllowToUpdateByCustomer;
  List<LogProject>? logProject;

  ItemProject({
    this.id,
    this.uidCustomer,
    this.namaProject,
    this.deskripsiProject,
    this.tanggalCreated,
    this.tanggalUpdated,
    this.isAllowToUpdateByCustomer,
    this.logProject,
  });

  ItemProject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uidCustomer = json['uidCustomer'];
    namaProject = json['namaProject'];
    deskripsiProject = json['deskripsiProject'];
    tanggalCreated = json['tanggalCreated'];
    tanggalUpdated = json['tanggalUpdated'];
    isAllowToUpdateByCustomer = json['isAllowToUpdateByCustomer'];
    if (json['logProject'] != null) {
      logProject = <LogProject>[];
      json['logProject'].forEach((v) {
        logProject?.add(LogProject.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['uidCustomer'] = uidCustomer;
    data['namaProject'] = namaProject;
    data['deskripsiProject'] = deskripsiProject;
    data['tanggalCreated'] = tanggalCreated;
    data['tanggalUpdated'] = tanggalUpdated;
    data['isAllowToUpdateByCustomer'] = isAllowToUpdateByCustomer;
    if (logProject != null) {
      data['logProject'] = logProject?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        uidCustomer,
        namaProject,
        deskripsiProject,
        tanggalCreated,
        tanggalUpdated,
        isAllowToUpdateByCustomer,
        logProject,
      ];
}
