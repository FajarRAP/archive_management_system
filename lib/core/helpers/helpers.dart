import 'package:flutter/material.dart';

import '../../features/archive/presentation/widgets/text_badge.dart';
import '../common/constants.dart';

Widget buildTextBadge(String archiveStatus) {
  switch (archiveStatus) {
    case availableStatus:
      return TextBadge(color: Colors.green, text: availableStatus);

    case borrowedStatus:
      return TextBadge(color: Colors.red, text: borrowedStatus);

    case lostStatus:
      return TextBadge(color: Colors.grey, text: lostStatus);
    default:
      return TextBadge(color: Colors.indigo, text: 'Undefined');
  }
}
