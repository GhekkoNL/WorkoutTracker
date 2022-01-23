import 'package:flutter/material.dart';
import 'package:workout_tracker/dbModels/workout_entry_model.dart';
import 'package:workout_tracker/util/typedef.dart';
import 'package:workout_tracker/objectbox.g.dart';

class EditWorkoutEntryWidget extends StatefulWidget {
  final WorkoutEntry entry;
  final Box<WorkoutEntry> workoutBox;

  EditWorkoutEntryWidget({Key? key,required this.workoutBox, required this.entry}) : super(key: key);

  @override
  State createState() => _EditWorkoutState();
}

class _EditWorkoutState extends State<EditWorkoutEntryWidget> {
  final workoutNameController = TextEditingController();
  final descriptionController = TextEditingController();
  late String part, type, metric;

  void initState() {
    super.initState();
    part = widget.entry.part;
    type = widget.entry.type;
    metric = widget.entry.metric;
    workoutNameController.text = widget.entry.caption;
    descriptionController.text = widget.entry.description;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async{
          Navigator.pop(context, false);
          return false;
        },
        child: new Scaffold(
            appBar: AppBar(
              title: Text("Edit Workout"),
              backgroundColor: Colors.amberAccent,
            ),
            body: Builder(
                builder: (context) =>
                    SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // System Values
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                child: Text("Workout Name",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                  ),
                                )
                            ),
                            Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                margin: EdgeInsets.all(8.0),
                                child: Column(
                                    children: <Widget>[
                                      ListTile(
                                          title: new Row(
                                            children: <Widget>[
                                              new Flexible(
                                                  child: new TextField(
                                                    controller: workoutNameController,
                                                    decoration: InputDecoration(
                                                      border:InputBorder.none,
                                                      hintText: "Enter Name",
                                                    ),
                                                  )
                                              )
                                            ],
                                          )
                                      ),
                                    ]
                                )
                            ),
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                child: Text("Workout Details",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                  ),
                                )
                            ),
                            Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                margin: EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    ListTile(
                                        title: new Row(
                                          children: <Widget>[
                                            Text("Part"),
                                            Spacer(),
                                            DropdownButton<String>(
                                              value: part,
                                              iconSize: 24,
                                              elevation: 16,
                                              onChanged: (value){
                                                setState(() {part = value!;});
                                              },
                                              underline: Container(
                                                height: 2,
                                              ),
                                              selectedItemBuilder: (BuildContext context) {
                                                return PartType.values.map<Widget>((PartType value) {
                                                  return Container(
                                                      alignment: Alignment.centerRight,
                                                      width: 100, // TODO: Find Proper Width
                                                      child: Text(value.name, textAlign: TextAlign.end)
                                                  );
                                                }).toList();
                                              },
                                              items: PartType.values
                                                  .map<DropdownMenuItem<String>>((PartType value) {
                                                return DropdownMenuItem<String>(
                                                  value: value.name,
                                                  child: Text(value.name),
                                                );
                                              }).toList(),
                                            )
                                          ],
                                        )
                                    ), // Part Dropdown
                                    ListTile(
                                        title: new Row(
                                          children: <Widget>[
                                            Text("Type"),
                                            Spacer(),
                                            DropdownButton<String>(
                                              value: type,
                                              iconSize: 24,
                                              elevation: 16,
                                              onChanged: (value){
                                                setState(() {type = value!;});
                                              },
                                              underline: Container(
                                                height: 2,
                                              ),
                                              selectedItemBuilder: (BuildContext context) {
                                                return WorkoutType.values.map<Widget>((WorkoutType value) {
                                                  return Container(
                                                      alignment: Alignment.centerRight,
                                                      width: 100, // TODO: Find Proper Width
                                                      child: Text(value.name, textAlign: TextAlign.end)
                                                  );
                                                }).toList();
                                              },
                                              items: WorkoutType.values
                                                  .map<DropdownMenuItem<String>>((WorkoutType value) {
                                                return DropdownMenuItem<String>(
                                                  value: value.name,
                                                  child: Text(value.name),
                                                );
                                              }).toList(),
                                            )
                                          ],
                                        )
                                    ), // Type Dropdown
                                    ListTile(
                                        title: new Row(
                                          children: <Widget>[
                                            Text("Metric"),
                                            Spacer(),
                                            DropdownButton<String>(
                                              value: metric,
                                              iconSize: 24,
                                              elevation: 16,
                                              onChanged: (value){
                                                setState(() {metric = value!;});
                                              },
                                              underline: Container(
                                                height: 2,
                                              ),
                                              selectedItemBuilder: (BuildContext context) {
                                                return MetricType.values.map<Widget>((MetricType value) {
                                                  return Container(
                                                      alignment: Alignment.centerRight,
                                                      width: 100, // TODO: Find Proper Width
                                                      child: Text(value.name, textAlign: TextAlign.end)
                                                  );
                                                }).toList();
                                              },
                                              items: MetricType.values
                                                  .map<DropdownMenuItem<String>>((MetricType value) {
                                                return DropdownMenuItem<String>(
                                                  value: value.name,
                                                  child: Text(value.name),
                                                );
                                              }).toList(),
                                            )
                                          ],
                                        )
                                    ), // Metric Dropdown
                                  ],
                                )
                            ),
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                child: Text("Description",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                  ),
                                )
                            ),
                            Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                margin: EdgeInsets.all(8.0),
                                child: Column(
                                    children: <Widget>[
                                      ListTile(
                                          title: new Row(
                                            children: <Widget>[
                                              new Flexible(
                                                  child: new TextFormField(
                                                    keyboardType: TextInputType.multiline,
                                                    maxLines: null,
                                                    minLines: 4,
                                                    controller: descriptionController,
                                                    decoration: InputDecoration(
                                                      border:InputBorder.none,
                                                      hintText: "(Optional)",
                                                    ),
                                                  )
                                              )
                                            ],
                                          )
                                      ),
                                    ]
                                )
                            ),
                            Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                                margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                color: Theme.of(context).colorScheme.primary,
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ListTile(
                                          onTap:(){
                                            if(workoutNameController.text.isEmpty) {
                                              final snackBar = SnackBar(
                                                content: const Text('Please enter name for new workout'),
                                              );

                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                              return;
                                            }

                                            widget.entry.caption = workoutNameController.text;
                                            widget.entry.type = type;
                                            widget.entry.part = part;
                                            widget.entry.metric = metric;
                                            widget.entry.description = descriptionController.text;

                                            widget.workoutBox.put(widget.entry);
                                            Navigator.pop(context, true);
                                          },
                                          title: Text("Save Changes",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                      )
                                    ]
                                )
                            ),// Save Button
                          ],
                        )
                    )
            )
        )
    );
  }
}