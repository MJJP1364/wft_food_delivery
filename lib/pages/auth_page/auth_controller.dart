import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final supabase = Supabase.instance.client;
  User? user;

  

  @override
  void onInit() {
    _getAuth();
    super.onInit();
  }

  Future<void> _getAuth() async {
    user = supabase.auth.currentUser;

    supabase.auth.onAuthStateChange.listen((event) {
      user = event.session?.user;
    });
  }
}
