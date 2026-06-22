// import 'dart:developer';

// import 'package:supabase_flutter/supabase_flutter.dart';

// class SubaPaseMethods {
//   factory SubaPaseMethods() {
//     return _supa;
//   }
//   SubaPaseMethods._internal();
//   static final SubaPaseMethods _supa = SubaPaseMethods._internal();
//   static Future<void> createProfile({
//     required String userId,
//     required String email,
//     required String method,
//     String? userName,
//   }) async {
//     //   supabase.auth.onAuthStateChange.listen((data) async {
//     //     final session = data.session;
//     //     final user = session?.user;

//     //     if (user == null) return;

//     //   });
//     bool isExsist = await exists(userId: userId);
//     if (isExsist) {
//       return;
//     }

//     if (!isExsist) {
//       await supabase.from(SupabaseTablesKeys.profilesTable).insert({
//         'user_id': userId,
//         'email': email,
//         'method': method,
//         'userName': userName ?? '',
//       });
//     }
//   }

//   static Future<void> signInWithGoogle() async {
//     try {
//       await supabase.auth.signInWithOAuth(
//         OAuthProvider.google,
//         redirectTo: 'com.dev.donta://login-callback',
//       );
//       // final user = supabase.auth.currentUser;
//       // await SubaPaseMethods.createProfile(
//       //   userId: user!.id,
//       //   email: user.email!,
//       //   method: 'google',
//       //   userName: user.userMetadata?['full_name'] ?? '',
//       // );
//     } on AuthApiException catch (e) {
//       Helper.flutterToast(message: mapAuthError(e));
//     } catch (e) {
//       Helper.flutterToast(message: "Google sign-in failed");
//     }
//   }

//   static Future<void> signInWithFacebook() async {
//     try {
//       await supabase.auth.signInWithOAuth(
//         OAuthProvider.facebook,
//         redirectTo: 'com.dev.donta://login-callback',
//         authScreenLaunchMode: LaunchMode.externalApplication,
//       );
//     } on AuthApiException catch (e) {
//       Helper.flutterToast(message: mapAuthError(e));
//     } catch (e) {
//       log("FB LOGIN ERROR: $e");
//       Helper.flutterToast(message: "Facebook login failed");
//     }
//   }

//   static Future<bool> exists({required String userId}) async {
//     final res = await supabase
//         .from(SupabaseTablesKeys.profilesTable)
//         .select('user_id')
//         .eq('user_id', userId)
//         .maybeSingle();

//     return res != null;
//   }
// }
/*
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  /// 🔹 REGISTER
  Future<AuthResponse> register({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
    );

    return response;
  }

  /// 🔹 LOGIN


  /// 🔹 LOGOUT
  Future<void> logout() async {
    await _client.auth.signOut();
  }

  /// 🔹 GET CURRENT USER
  User? get currentUser => _client.auth.currentUser;

  /// 🔹 CHECK AUTH STATE
  Stream<AuthState> get authState => _client.auth.onAuthStateChange;
}
*/