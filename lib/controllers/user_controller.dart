import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:food_order_ui/user/user_service.dart';
import 'package:food_order_ui/user/user_model.dart';

class UserController extends GetxController {
  final UserService _userService = UserService();
  final RxList<Users> users = RxList<Users>();

  @override
  void onInit() {
    super.onInit();
    fetchAllUsers();
  }

  Future<List<Users>> fetchAllUsers() async {
    try {
      List<Users> allUsers = await _userService.getAllUsers();
      users.assignAll(allUsers);
      print('Number of users fetched: ${users.length}');
      return allUsers;
    } catch (e) {
      print('Error fetching all users: $e');
      return [];
    }
  }

  Future<void> deleteUser(String? userId) async {
    try {
      if (userId != null) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userId)
            .delete();

        users.removeWhere((user) => user.userID == userId);

        update();
      } else {
        print('Error: User ID is null.');
      }
    } catch (e) {
      print('Error deleting user: $e');
    }
  }
}
