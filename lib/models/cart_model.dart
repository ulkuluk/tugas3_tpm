import 'package:tugas3_tpm/models/game_store.dart';

class CartModel {
  static final List<GameStore> cartItems = [];

  static void add(GameStore item) {
    if (!cartItems.contains(item)) {
      cartItems.add(item);
    }
  }

  static bool contains(GameStore item) {
    return cartItems.any((element) => element.name == item.name);
  }

  static void remove(GameStore item) {
    cartItems.remove(item);
  }

  static void clear() {
    cartItems.clear();
  }

  static List<GameStore> get items => List.unmodifiable(cartItems);

  static void replaceAll(List<Future<void>> restored) {}
}
