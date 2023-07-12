import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mirai_dev_order_monitoring/app/models/user_app.dart';

class AuthController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Rxn<User?> user = Rxn<User?>();
  Rxn<UserApp?> userApp = Rxn<UserApp?>();
  Rx<bool> isLoadingData = false.obs;

  @override
  void onInit() {
    super.onInit();
    user.bindStream(
      firebaseAuth.userChanges(),
    );

    user.listen((value) async {
      if (value != null) {
        await loadDataUser(value.uid).then((value) {});
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void toggleIsLoadingData() {
    this.isLoadingData.toggle();
  }

  Future<void> registerUser(
      String roleUser, String nomorSTR, String email, String password) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        UserApp userApp = UserApp(
          uid: value.user!.uid,
          email: email,
          roleUser: roleUser,
        );

        await FirebaseFirestore.instance
            .collection("users")
            .doc(value.user!.uid)
            .set(userApp.toJson())
            .then((value) {
          Get.back(closeOverlays: true);
          Get.snackbar("Register Berhasil", "Anda telah terdaftar di aplikasi");
        });
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Get.snackbar("Register Gagal", "Email anda telah terdaftar");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        Get.snackbar("Login Berhasil", "Anda telah login ke dalam aplikasi");
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.snackbar("Login Gagal", "Email anda belum terdaftar");
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Get.snackbar("Login Gagal", "Password anda salah");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> logoutUser() async {
    Get.back(closeOverlays: true);

    toggleIsLoadingData();

    await Future.delayed(Duration(seconds: 1));

    try {
      await firebaseAuth.signOut().then((value) {
        Get.snackbar("Logout Berhasil", "Anda telah logout dari aplikasi");
      });
    } catch (e) {
      print(e);
    }

    toggleIsLoadingData();
  }

  Future<void> updateDataUser(UserApp userApp) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userApp.uid!)
          .update(userApp.toJson())
          .then((value) async {
        await loadDataUser(userApp.uid!).then((value) {
          Get.back(closeOverlays: true);
          Get.snackbar("Update Berhasil", "Data diri anda berhasil di-update.");
        });
      });
    } catch (e) {
      print(e);
      Get.snackbar("Sistem Error", "Silahkan hubungin developer.");
    }
  }

  Future<void> loadDataUser(String uid) async {
    toggleIsLoadingData();

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get()
          .then((value) {
        var dataUser = value.data();

        if (dataUser != null) {
          UserApp userApp = UserApp.fromJson(dataUser);

          this.userApp.value = userApp;
        } else {
          Get.snackbar("Login Gagal", "Data user tidak ditemukan");
        }
      });
    } catch (e) {
      print(e);
      Get.snackbar("Sistem Error", "Silahkan hubungin developer.");
    }

    await Future.delayed(Duration(seconds: 1));

    toggleIsLoadingData();
  }
}
