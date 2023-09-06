import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class CoffeeShopFirebaseUser {
  CoffeeShopFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

CoffeeShopFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<CoffeeShopFirebaseUser> coffeeShopFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<CoffeeShopFirebaseUser>(
            (user) => currentUser = CoffeeShopFirebaseUser(user));
