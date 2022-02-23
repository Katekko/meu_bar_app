import 'package:uuid/uuid.dart';

abstract class ISearchable {
  final String guid;
  final String desc;
  ISearchable({required this.desc}) : guid = const Uuid().v1();
}
