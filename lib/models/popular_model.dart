class PopularDietsModel {
  String name;
  String iconPath;
  String level;
  String duration;
  String recommended;
  bool boxIsSelected;

  PopularDietsModel({
    required this.name,
    required this.iconPath,
    required this.level,
    required this.duration,
    required this.recommended,
    required this.boxIsSelected
  });

  static List < PopularDietsModel > getPopularDiets() {
    List < PopularDietsModel > popularDiets = [];

    popularDiets.add(
      PopularDietsModel(
       name: 'Reading Books',
       iconPath: 'assets/icons/reading.svg',
       level: 'Meduim',
       duration: '30mins',
        recommended: 'Highly Effective',
       boxIsSelected: true,
      )
    );

    popularDiets.add(
      PopularDietsModel(
       name: 'Listening Music',
       iconPath: 'assets/icons/music.svg',
       level: 'Easy',
       duration: '20mins',
        recommended: 'Highly Effective',
       boxIsSelected: true,
      )
    );

    popularDiets.add(
        PopularDietsModel(
          name: 'Journalling',
          iconPath: 'assets/icons/journaling.svg',
          level: 'Medium',
          duration: '10mins',
          recommended: 'Highly Effective',
          boxIsSelected: true,
        )
    );

    popularDiets.add(
        PopularDietsModel(
          name: 'Meditation',
          iconPath: 'assets/icons/meditation.svg',
          level: 'Medium',
          duration: '45mins',
          recommended: 'Highly',
          boxIsSelected: true,
        )
    );


    return popularDiets;
  }
}