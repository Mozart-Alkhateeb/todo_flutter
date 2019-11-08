import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../models/todo.dart';

class ManageTodoWidget extends StatefulWidget {
  final ToDo todo; // a new or existing todo 
  final Function saveChanges; // Function passed by the parent widget to save changes

  const ManageTodoWidget({Key key, this.todo, this.saveChanges})
      : super(key: key);

  @override
  _ManageTodoWidgetState createState() => _ManageTodoWidgetState();
}

class _ManageTodoWidgetState extends State<ManageTodoWidget> {
  ApiService _apiService;
  Future<List<String>> _statuses;

// Define the form key that preserve the state of the form
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
    _statuses = _apiService.getStatuses();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextFormField(
                initialValue: widget.todo.description,
                onSaved: (value) {
                  widget.todo.description = value; // on saved we persist the form state
                },
              ),
              FutureBuilder(
                future: _statuses, // Future like the on inside the home screen
                builder: (_, AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                          "Something wrong with message: ${snapshot.error.toString()}"),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    var statuses = snapshot.data;
                    return DropdownButtonFormField( // Building a drop down list with all statuses
                      hint: Text('Select Todo'),
                      value: widget.todo.status,
                      onChanged: (status) {
                        setState(() {
                          widget.todo.status = status;
                        });
                      },
                      items: statuses.map(
                        (status) {
                          return DropdownMenuItem(
                            child: Text(status),
                            value: status,
                          );
                        },
                      ).toList(),
                      onSaved: (value) => widget.todo.status = value, // on saved we persist the form state
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
              FlatButton(
                child: Text(
                  'Save Changes',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  _form.currentState.save(); // we call the save method in order to invoke the onsaved method on form fields
                  this.widget.saveChanges(widget.todo); // call the save changes method that was passed by the parent widget
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
