import 'package:flutter/material.dart';

class StudyModel {
  String name;
  String iconPath;
  String level;
  String duration;
  String calorie;
  Color boxColor;
  bool viewIsSelected;

  StudyModel({
    required this.name,
    required this.iconPath,
    required this.level,
    required this.duration,
    required this.calorie,
    required this.boxColor,
    required this.viewIsSelected
  });

  static List < StudyModel > getDiets() {
    List < StudyModel > diets = [];

    diets.add(
        StudyModel(
       name: 'Healthy Eating',
       iconPath: 'assets/icons/eating.svg',
       level: 'Easy',
       duration: '30mins',
       calorie: '180kCal',
       viewIsSelected: true,
       boxColor: Color(0xff9DCEFF)
      )
    );

    diets.add(
        StudyModel(
       name: 'Stay Hydrated',
       iconPath: 'assets/icons/water.svg',
       level: 'Easy',
       duration: '20mins',
       calorie: '230kCal',
       viewIsSelected: true,
       boxColor: Color(0xffEEA4CE)
      )
    );

    return diets;
  }
}