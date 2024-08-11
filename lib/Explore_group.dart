import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Explore_group extends StatefulWidget {


  @override
  State<Explore_group> createState() => _Explore_groupState();
}

class _Explore_groupState extends State<Explore_group> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Stack(
        children: [
          SvgPicture.asset(
            'assets/Ellipse/Ellipse 7.svg',

          ),
          Stack(
            children: [
              Positioned(
                left: 40,
                top: 66,
                child: Container(
                  width: 314,
                  height: 304,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: Color(0xFF64A78F),
                  ),
                ),
              ),
              Positioned(
                left: 52,
                top: 98,
                child: Container(
                  width: 197,
                  height: 41,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: Color(0xFF92D8BF),
                  ),
                ),
              ),



            ],
          ),
        ],
      ),
    );
  }
}
