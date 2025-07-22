import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final log = Logger(
  level: ["sandbox", "staging"].contains(const String.fromEnvironment('ENV')) ? Level.all : Level.off,
  printer: PrettyPrinter(
    methodCount: 1,
    lineLength: 110,
  ),
);

IconData getIcon(String type) {
  switch (type) {
    case 'zap':
      return Icons.record_voice_over_outlined;
    case 'beep':
      return Icons.notifications_active;
    case 'vibe':
      return Icons.vibration;
    default:
      return Icons.vibration;
  }
}

/// Height
List<Text> getListHeightCm1() {
  return List.generate(121, (index) => 100 + index).map((e) => Text(e.toString())).toList();
}

List<Text> getListHeightFtIn1() {
  return List.generate(5, (index) => 4 + index).map((e) => Text("$e'")).toList();
}

List<Text> getListHeightCm2() {
  return List.generate(11, (index) => 0 + index).map((e) => Text('.${e.toString()}')).toList();
}

List<Text> getListHeightFtIn2() {
  return List.generate(12, (index) => 0 + index).map((e) => Text('${e.toString()}"')).toList();
}

/// Weight

List<Text> getListWeightKg() {
  return List.generate(151, (index) => 30 + index).map((e) => Text(e.toString())).toList();
}

List<Text> getListWeightLb1() {
  return List.generate(396, (index) => 65 + index).map((e) => Text(e.toString())).toList();
}

List<Text> getListWeight2() {
  return List.generate(11, (index) => 0 + index).map((e) => Text('.${e.toString()}')).toList();
}