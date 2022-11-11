import 'package:agenda/models/mission.dart';

const months = [
  'Janeiro',
  'Fevereiro',
  'Março',
  'Abril',
  'Maio',
  'Junho',
  'Julho',
  'Agosto',
  'Setembro',
  'Outubro',
  'Novembro',
  'Dezembro'
];

const weekdays = ['DOM', 'SEG', 'TER', 'QUA', 'QUI', 'SEX', 'SAB'];

final now = DateTime.now();
final today = DateTime(now.year, now.month, now.day);

final allEvents = [
  Mission(
      ministry: 'Música', dateTime: DateTime(2022, 11, 9), missionaries: []),
];
