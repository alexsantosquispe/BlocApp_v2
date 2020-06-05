import 'dart:async';
import 'package:BlocApp_v2/src/bloc/EmployeeEvent.dart';
import 'package:BlocApp_v2/src/models/Employee.dart';

class EmployeeBloc {
  List<Employee> _employeeList = [
    Employee(1, "Juanito", 1000.0),
    Employee(2, "Pepito", 2000.0),
    Employee(3, "Alvarito", 3000.0),
    Employee(4, "Marcelo", 4000.0),
    Employee(5, "Pancho", 5000.0),
    Employee(6, "D4nny", 6000.0)
  ];

  //Stream Controllers
  final _eventStreamController = StreamController<BaseCounter>();
  //final _employeeStreamController = StreamController<Employee>();
  final _employeeListStreamController = StreamController<List<Employee>>();

  EmployeeBloc() {
    _eventStreamController.stream.listen(mapEventToState);
    _employeeListStreamController.add(_employeeList);
  }

  StreamSink<BaseCounter> get sendEvent => _eventStreamController.sink;
  //Stream<Employee> get counterSalary => _employeeStreamController.stream;
  Stream<List<Employee>> get employeesListStream =>
      _employeeListStreamController.stream;

  void mapEventToState(BaseCounter event) {
    if (event is PopulateEmployee) {
      _employeeListStreamController.add(_employeeList);
    } else if (event is IncrementSalary) {
      Employee employee = event.payload;
      double newSalary = employee.salary + 100;

      employee.salary = newSalary;
      _employeeList[employee.id - 1].salary = employee.salary;
    } else if (event is DecrementSalary) {
      Employee employee = event.payload;
      double newSalary = employee.salary - 100;

      employee.salary = newSalary;
      _employeeList[employee.id - 1].salary = employee.salary;
    }
    _employeeListStreamController.add(_employeeList);
  }

  void dispose() {
    _eventStreamController.close();
    _employeeListStreamController.close();
  }
}
