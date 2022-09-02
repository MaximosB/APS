import 'package:acamp_kids/View/Perfil.dart';
import 'package:acamp_kids/View/principal.dart';
import 'package:flutter/material.dart';
import 'package:acamp_kids/autenticationService.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:acamp_kids/View/login.dart';
import 'package:get/get.dart';

class CheckAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(
        () => AuthService.to.userIsAuthenticated.value ? Principal() : Login());
  }
}
