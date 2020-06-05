import 'package:BlocApp_v2/src/bloc/EmployeeEvent.dart';
import 'package:flutter/material.dart';
import '../models/Employee.dart';
import '../bloc/EmployeeBloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EmployeeBloc _bloc = EmployeeBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Salaries'),
      ),
      body: Container(
        child: StreamBuilder<List<Employee>>(
          stream: _bloc.employeesListStream,
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (item, index) {
                return Card(
                  elevation: 3.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          '${snapshot.data[index].id}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          '${snapshot.data[index].name}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "Bs. ${snapshot.data[index].salary}",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.add_circle),
                          color: Colors.blue,
                          onPressed: () {
                            _bloc.sendEvent
                                .add(IncrementSalary(snapshot.data[index]));
                          },
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.remove_circle),
                          color: Colors.red,
                          onPressed: () {
                            _bloc.sendEvent
                                .add(DecrementSalary(snapshot.data[index]));
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
