import 'package:broadway_example_ui/users/user_event.dart';
import 'package:broadway_example_ui/users/user_model.dart';
import 'package:broadway_example_ui/users/user_service.dart';
import 'package:broadway_example_ui/users/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserService service;
  UserBloc(this.service) : super(UserInitial()) {
    List<UserModel> users = [];
    on<GetUser>((event, emit) async {
      emit(UserLoading());
      final data = await service.getUser();
      users = data;
      emit(UserLoaded(users));
    });
    on<DeleteUser>((event, emit) {
      emit(UserLoading());
      users.removeAt(event.index);
      emit(UserLoaded(users));
    });
  }
}
