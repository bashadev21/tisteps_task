abstract class UserEvent {}

class LoadUser extends UserEvent {
  final int userId;
  LoadUser(this.userId);
}
