abstract class UserEvent {}

class GetUser extends UserEvent {}

class DeleteUser extends UserEvent {
  int index;
  DeleteUser(this.index);
}
