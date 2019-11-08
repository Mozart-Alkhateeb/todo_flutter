import 'dart:convert';
// A flutter class that resemble our rest API's request response data
class ToDo {
  final int id;
  String description;
  String status;

// Flutter way of creating a constructor
  ToDo({this.id = 0, this.description = '', this.status = 'Pending'});

// factory for mapping JSON to current instance of the Todo class
  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'],
      description: json['description'],
      status: json['status'],
    );
  }

// Instance method for converting a todo item to a map
  Map<String, dynamic> toMap() {
    return {"id": id, "description": description, "status": status};
  }

}

//  A helper method that converts a json array into List<ToDo>
List<ToDo> fromJson(String jsonData) {

  // Decode json to extract a map
  final data = json.decode(jsonData);

  // Map each todo JSON to a Todo object and return the result as a List<ToDo>
  return List<ToDo>.from(data.map((item) => ToDo.fromJson(item)));
}

// A helper method to convert the todo object to JSON String
String toJson(ToDo data) {
  // First we convert the object to a map
  final jsonData = data.toMap();

  // Then we encode the map as a JSON string
  return json.encode(jsonData);
}
