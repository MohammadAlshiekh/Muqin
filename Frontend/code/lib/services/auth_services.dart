import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  signInWithGoogle() async{
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final OAuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken
      );
      return await FirebaseAuth.instance.signInWithCredential(googleCredential);
    }catch(e){
      print(e.toString());
    }
      
  }
}