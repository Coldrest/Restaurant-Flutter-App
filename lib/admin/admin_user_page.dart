import 'package:flutter/material.dart';
import 'package:food_order_ui/controllers/user_controller.dart';
import 'package:food_order_ui/user/user_model.dart';
import 'package:get/get.dart';

class UserProfilePage extends StatelessWidget {
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kullanıcılar',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple, Colors.indigo],
          ),
        ),
        child: Obx(() {
          List<Users> users = userController.users;

          return ListView(
            padding: EdgeInsets.all(16),
            children: users
                .map(
                  (user) => Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ad-Soyad: ${user.namesurname}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'E-Mail: ${user.email}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Telefon Numarası: ${user.phoneNumber}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              if (user.userID != null) {
                                userController.deleteUser(user.userID);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Kullanıcı silindi'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              } else {
                                print('Error: User ID is null.');
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          );
        }),
      ),
    );
  }
}
