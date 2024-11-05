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

const availableStatus = 'Tersedia';
const borrowedStatus = 'Dipinjam';
const lostStatus = 'Hilang';

const loginRoute = '/login';
const homeRoute = '/';
const archiveRoute = '${homeRoute}archive';
const addArchiveRoute = '${homeRoute}add-archive';
const returnArchiveRoute = '/return-archive';

const reportRoute = '${homeRoute}report';

const profileRoute = '${homeRoute}profile';
