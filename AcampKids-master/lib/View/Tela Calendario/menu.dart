import 'package:acamp_kids/autenticationService.dart';
import 'package:flutter/material.dart';

Widget menu(BuildContext context) {
  return Container(
    width: 200,
    height: 400,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/menu/ActionMenu.png"),
        fit: BoxFit.fill,
      ),
    ),
    child: Stack(
      children: [
        Align(
          alignment: Alignment(
              (Alignment.topRight.x * 0.95), (Alignment.topRight.y * 0.97)),
          child: InkResponse(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Image.asset(
              "assets/semanal/Back.png",
            ),
          ),
        ),
        // Align(
        //   alignment:
        //       Alignment((Alignment.topCenter.x), (Alignment.topCenter.y * 0.3)),
        //   child: ElevatedButton(
        //     child: const Text(
        //       'Ajuda',
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontFamily: 'Riffic',
        //         fontSize: 32,
        //       ),
        //     ),
        //     style: ElevatedButton.styleFrom(
        //       primary: Color(0xFF289A2F),
        //       shadowColor: Color(0xFF23732A),
        //       fixedSize: const Size(240, 57.11),
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(30),
        //       ),
        //     ),
        //     //TODO: - Ajuda
        //     onPressed: () {},
        //   ),
        // ),
        Align(
          alignment: Alignment(
              (Alignment.center.x), (Alignment.center.y * 0.3)),
          child: ElevatedButton(
            child: const Text(
              'Sair',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Riffic',
                fontSize: 32,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFD3272D),
              shadowColor: Color(0xFFA9232D),
              fixedSize: const Size(240, 57.11),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            //TODO: - Sair do APP
            onPressed: () {
              AuthService.to.logout();
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    ),
  );
}
