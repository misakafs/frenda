import 'user.dart';

void main() {
  final user = User(name: 'test');

  print(user.toJson());
  print(user.hashCode);
}
