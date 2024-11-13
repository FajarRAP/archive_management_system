import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart';

import '../../features/archive/domain/entities/archive_entity.dart';
import '../../features/archive/domain/entities/archive_loan_entity.dart';
import '../../features/archive/presentation/widgets/text_badge.dart';
import '../common/constants.dart';

Widget buildTextBadgeArchiveLoan(ArchiveLoanEntity archiveLoan) {
  if (archiveLoan.returnedAt == null) {
    return TextBadge(color: Colors.red, text: borrowedStatus);
  }

  if (archiveLoan.returnedAt != null) {
    return TextBadge(color: Colors.green, text: availableStatus);
  }

  return TextBadge(color: Colors.grey, text: lostStatus);
}

Widget buildTextBadgeArchive(ArchiveEntity archive) {
  switch (archive.status) {
    case availableStatus:
      return TextBadge(color: Colors.green, text: availableStatus);
    case borrowedStatus:
      return TextBadge(color: Colors.red, text: borrowedStatus);
    default:
      return TextBadge(color: Colors.grey, text: lostStatus);
  }
}

String convertTimeAgo(DateTime date) {
  setLocaleMessages('id', IdMessages());
  return format(date, locale: 'id');
}
