import 'package:bloc/bloc.dart';

import 'new_ministry_states.dart';

class NewMinistryController extends Cubit<NewMinistryState>{
  NewMinistryController():super(InitialNewMinistryState());
}