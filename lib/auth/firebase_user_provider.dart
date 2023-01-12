import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class BonuzeFirebaseUser {
  BonuzeFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

BonuzeFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<BonuzeFirebaseUser> bonuzeFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<BonuzeFirebaseUser>(
      (user) {
        currentUser = BonuzeFirebaseUser(user);
        return currentUser!;
      },
    );
