import 'package:prize24_app/repository/user/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'customer_name_controller.g.dart';

@riverpod
class CustomerNameController extends _$CustomerNameController {
  @override
  FutureOr<String?> build({required String customerId}) {
    if (customerId.isEmpty) {
      return 'Unknown Customer';
    }
    return ref.read(userRepositoryProvider).getUserNameById(customerId);
  }
}
