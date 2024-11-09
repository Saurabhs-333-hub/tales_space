import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

contextWidth(context, n) {
  return MediaQuery.of(context).size.width / n;
}

contextHeight(context, n) {
  return MediaQuery.of(context).size.height / n;
}

final bottomPositionProvider = StateProvider<double>((ref) {
  return 16;
});
