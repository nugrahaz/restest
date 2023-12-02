part of '../constants.dart';

class AssetsPath {
  static final fontFamily = _FontFamily();
  static final lotties = _Lotties();
  static final images = _Images();
}

//Font Familly
class _FontFamily {
  final poppinsBold = 'poppins_bold';
  final poppinsMedium = 'poppins_medium';
  final poppinsSemiBold = 'poppins_semi_bold';
}


class _Lotties {
  static const path = 'assets/lotties';

  //
  final key = "$path/key.json";
  final exit = "$path/exit.json";
  final noConnection = "$path/no_connection.json";
}

class _Images {
  static const path = 'assets/images';
  //
  final flowBottom = '$path/flow_bottom.png';
  final flowTop = '$path/flow_top.png';
}


