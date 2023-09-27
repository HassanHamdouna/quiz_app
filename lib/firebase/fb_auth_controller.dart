import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/models/fb_response.dart';

class FbAuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<FbResponse> createUser(String name) async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      userCredential.user!;
      return FbResponse('Registered successfully , verify name ', true);
    } on FirebaseAuthException catch (e) {
      return FbResponse(e.message ?? 'error', false);
    } catch (e) {
      return FbResponse('Something went Wrong', false);
    }
  }

  User get currentUser => _auth.currentUser!;
  bool get loggedIn => _auth.currentUser != null;
}