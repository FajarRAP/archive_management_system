import 'package:flutter/material.dart';

final rootScaffoldMessengerState = GlobalKey<ScaffoldMessengerState>();

const cardBoxShadow = [
  BoxShadow(
    color: Color.fromRGBO(158, 158, 158, .25),
    spreadRadius: 1,
    blurRadius: 8,
    offset: Offset(0, 2),
  ),
];

const archiveTable = 'archives';
const archiveLoanTable = 'archive_loans';
const profileTable = 'profiles';
const statusOptions = [availableStatus, borrowedStatus, lostStatus];

const availableStatus = 'Tersedia';
const borrowedStatus = 'Dipinjam';
const lostStatus = 'Hilang';

const loginRoute = '/login';
const homeRoute = '/';
const archiveRoute = '${homeRoute}archive';
const addArchiveRoute = '${homeRoute}add-archive';
const borrowArchiveRoute = '${homeRoute}borrow-archive';
const returnArchiveRoute = '${homeRoute}return-archive';
const returnArchiveDetailRoute = '$returnArchiveRoute/detail';

const reportRoute = '${homeRoute}report';

const profileRoute = '${homeRoute}profile';

const subdistrictsAndUrban = {
  'Pontianak Barat': [
    'Pal Lima',
    'Sungai Beliung',
    'Sungaijawi Dalam',
    'Sungaijawi Luar'
  ],
  'Pontianak Kota': [
    'Daratsekip',
    'Mariana',
    'Sungaibangkong',
    'Sungaijawi Tengah',
  ],
  'Pontianak Selatan': [
    'Akcaya',
    'Benuamelayu Darat',
    'Benuamelayu Laut',
    'Kotabaru',
    'Parittokaya',
  ],
  'Pontianak Tenggara': [
    'Bangka Belitung Darat',
    'Bangka Belitung Laut',
    'Bansir Darat',
    'Bansir Laut',
  ],
  'Pontianak Timur': [
    'Banjar Serasan',
    'Dalambugis',
    'Paritmayor',
    'Saigon',
    'Tambelansampit',
    'Tanjunghulu',
    'Tanjunghilir',
  ],
  'Pontianak Utara': [
    'Batulayang',
    'Siantan Hilir',
    'Siantan Hulu',
    'Siantan Tengah',
  ],
};
