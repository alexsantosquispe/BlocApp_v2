import 'package:BlocApp_v2/src/models/Employee.dart';

class BaseCounter {}

class PopulateEmployee extends BaseCounter {}

class IncrementSalary extends BaseCounter {
  final Employee payload;
  IncrementSalary(this.payload);
}

class DecrementSalary extends BaseCounter {
  final Employee payload;
  DecrementSalary(this.payload);
}
