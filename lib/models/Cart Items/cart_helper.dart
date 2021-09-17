import 'package:new_flutter_mbdimsum/basics/base_helper.dart';
import 'package:new_flutter_mbdimsum/models/Cart%20Items/cart_items.dart';
import 'package:new_flutter_mbdimsum/models/Products/products.dart';

class CartItemsHelper extends BaseHelper {
  @override
  String route = "Orders";

  CartItems productToCartItems(Products products) {
    return CartItems(
        itemName: products.name,
        itemID: products.productId,
        price: products.price,
        quantity: 0,
        stock: products.stock);
  }
}
