import 'package:new_flutter_mbdimsum/models/Cart/cart.dart';

const diff = Duration.millisecondsPerDay * 100;

extension CartExtensions on List<Cart> {
  void sortByEventDate() {
    sort(
      (left, right) {
        int leftVal = left.dateTime.millisecondsSinceEpoch;
        int rightVal = right.dateTime.millisecondsSinceEpoch;

        if (leftVal < rightVal) {
          leftVal = 1;
          rightVal = 0;
        } else {
          leftVal = 0;
          rightVal = 1;
        }
        return leftVal - rightVal;
      },
    );
  }
}
