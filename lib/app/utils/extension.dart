part of "utils.dart";

extension PercentSized on double {
  double get hp => (Get.height * ((this) / 100));

  double get wp => (Get.width * ((this) / 100));
}

