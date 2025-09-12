import 'package:hive/hive.dart';
part 'add_data.g.dart';

@HiveType(typeId: 1)
class AddData extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String explain;

  @HiveField(2)
  String amount;

  @HiveField(3)
  String IN;

  @HiveField(4)
  DateTime dateTime;
  AddData(
      this.IN,
      this.name,
      this.explain,
      this.amount,
      this.dateTime,
      );
}