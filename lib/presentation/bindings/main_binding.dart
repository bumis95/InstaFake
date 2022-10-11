import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../data/entities/user_entity.dart';
import '../../data/mappers/user_mapper.dart';
import '../../data/repositories/hive_user_repository.dart';
import '../controllers/main_controller.dart';
import '../controllers/profile_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    // Mappers
    Get.put<UserMapper>(UserMapper());
    // Repositories
    Get.put<HiveUserRepository>(
      HiveUserRepository(
        box: Hive.box<UserEntity>('users'),
        userMapper: Get.find<UserMapper>(),
      ),
      permanent: true,
    );
    // Bottom Navigation Controllers
    Get.put<ProfileController>(
      ProfileController(
        userRepository: Get.find<HiveUserRepository>(),
      ),
    );
    Get.put<MainController>(
      MainController(profileController: Get.find<ProfileController>()),
    );
  }
}
