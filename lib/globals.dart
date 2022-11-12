import 'package:agenda/models/mission.dart';
import 'package:agenda/models/person.dart';

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

// MOCKS FOR TESTING:

final user = Member('Eu', ['Ministério 1', 'Ministério 2']);

final allEvents = [
  Mission('Atividade 1',
      ministry: 'Ministério 1',
      dateTime: DateTime(today.year, today.month, 10),
      missionaries: [user.id]),
  Mission('Atividade 2',
      ministry: 'Ministério 2',
      dateTime: DateTime(today.year, today.month, 10),
      missionaries: []),
  Mission('Atividade 3',
      ministry: 'Ministério 1',
      dateTime: DateTime(today.year, today.month, 15),
      missionaries: []),
];
