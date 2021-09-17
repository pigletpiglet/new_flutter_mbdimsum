import 'package:new_flutter_mbdimsum/basics/base_helper.dart';
import 'package:new_flutter_mbdimsum/models/History/history.dart';

class HistoryHelper extends BaseHelper {
  @override
  String route = "History";

  Future<void> write(History history) async {
    await instance
        .collection(collectionPath)
        .doc(history.orderNumber)
        .set(history.toVariables());
  }

  History mapItem(Map<String, dynamic> map) {
    return History.fromMap(map);
  }
}
