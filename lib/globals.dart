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

final today = DateTime.now();

final allEvents = [
  Mission(ministry: 'Música', dateTime: today, missionaries: []),
];
