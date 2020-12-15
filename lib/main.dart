import 'dart:async';
import 'dart:html';
import 'dart:io';
import 'dart:math';
import 'package:ai_p/A_star.dart';
import 'package:ai_p/Cell.dart';
import 'package:ai_p/Maze.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_spinbox/material.dart';

enum Algorithm { BFS, IDDS, Astar }
List<Cell> path = new List<Cell>();
List<Cell> tmp_path = new List<Cell>();
Maze maze;
int cost = null;
int sw = 0;
int init = 0;
int wall = 120;
int left = 1;
int right = 1;
int up = 1;
int down = 1;
bool isRandon = false;
int tmpwall = 0;
int tampstart = 0;
int tmptarget = 0;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Path Planning',
        home: Container(
          child: Table(),
        ));
  }
}

class Table extends StatefulWidget {
  Table({Key key}) : super(key: key);
  @override
  createState() => _TableState();
}

class _TableState extends State<Table> {
  @override
  Widget build(BuildContext context) {
    if (init == 0) {
      Future.delayed(Duration.zero, () => showAlert3(context));
      return Material(
        color: Colors.blueGrey,
      );
    }
    return MaterialApp(
      title: 'Path Planning',
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey,
        ),
        child: GridView.count(
          childAspectRatio: (2 / 1),
          crossAxisCount: 20,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1.3,
          padding: EdgeInsets.all(6),
          children: List.generate(400, (index) {
            int xindex = index % 20;
            int yindex = ((index - xindex) / 20).round();
            Color color;
            Icon icon;
            bool swbut = false;
            for (var item in path) {
              if (item.getX() == xindex && item.getY() == yindex) {
                if (sw == 3)
                  icon = Icon(
                    Icons.accessible_forward,
                    color: Colors.black87,
                  );
                swbut = true;
                break;
              }
            }
            switch (maze.getList()[yindex][xindex]) {
              case 0:
                color = Colors.white;
                break;
              case 1:
                color = Colors.blueGrey;
                break;
              case 10:
                {
                  swbut = true;
                  color = Colors.green;
                  icon = Icon(
                    Icons.add_location,
                    color: Colors.black87,
                  );
                }
                break;
              case 20:
                {
                  swbut = true;
                  color = Colors.red;
                  icon = Icon(
                    Icons.adjust,
                    color: Colors.black87,
                  );
                }
                break;
            }
            return Container(
              decoration: BoxDecoration(
                color: color,
              ),
              child: swbut
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[icon],
                    )
                  : FlatButton(
                      color: color,
                      onPressed: () {
                        if (tampstart == 0) {
                          if (maze.addStart(xindex, yindex)) tampstart = 1;
                        } else if (tmptarget == 0) {
                          if (maze.addTarget(xindex, yindex)) tmptarget = 1;
                        } else if (tmpwall < wall) {
                          if (maze.addWall(xindex, yindex)) tmpwall++;
                          if (tmpwall == wall) showAlert(context);
                        }
                        setState(() {});
                      }),
            );
          }),
        ),
      ),
    );
  }

  void a_star() {
    sw = 3;
    Astar astar = new Astar(maze.getList(), maze.getStart(), maze.getTarget(),
        up, down, right, left);
    cost = astar.search();
    tmp_path = astar.getPath();
  }

  void showReuslt() {
    if (cost != null)
      for (var i = tmp_path.length - 1; i >= 0; i--) {
        new Timer(const Duration(seconds: 1),
            () => setState(() => path.add(tmp_path[i])));
      }
  }

  void showAlert(BuildContext context) async {
    showDialog<Algorithm>(
        context: context,
        barrierDismissible: true,
        builder: (context) => SimpleDialog(
              title: const Text('Are You Ready?!'),
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, Algorithm.Astar);
                    a_star();
                    ackAlert(context);
                    showReuslt();
                  },
                  child: const Text('Start!!!'),
                ),
              ],
            ));
  }

  void helpingAlert(BuildContext context) async {
    showDialog<Algorithm>(
        context: context,
        barrierDismissible: true,
        builder: (context) => SimpleDialog(
              title: const Text('Select Start, Target And Walls with click'),
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, Algorithm.Astar);
                  },
                  child: const Text('Ok'),
                ),
              ],
            ));
  }

  void showAlert2(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Please Set Arguments '),
            content: Container(
              width: 200,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SpinBox(
                    min: 0,
                    max: 400,
                    value: wall.toDouble(),
                    decoration: InputDecoration(labelText: 'Wall Count'),
                    onChanged: (value) {
                      wall = value.round();
                    },
                  ),
                  SpinBox(
                    min: 0,
                    max: 30,
                    value: 1,
                    decoration: InputDecoration(labelText: 'Right Cost'),
                    onChanged: (value) {
                      right = value.round();
                    },
                  ),
                  SpinBox(
                    min: 0,
                    max: 30,
                    value: 1,
                    decoration: InputDecoration(labelText: 'Left Cost'),
                    onChanged: (value) {
                      left = value.round();
                    },
                  ),
                  SpinBox(
                    min: 0,
                    max: 30,
                    value: 1,
                    decoration: InputDecoration(labelText: 'Up Cost'),
                    onChanged: (value) {
                      up = value.round();
                    },
                  ),
                  SpinBox(
                    min: 0,
                    max: 30,
                    value: 1,
                    decoration: InputDecoration(labelText: 'Down Cost'),
                    onChanged: (value) {
                      down = value.round();
                    },
                  ),
                ],
              ),
            ),
            actions: [
              new FlatButton(
                child: new Text('Submit'),
                onPressed: () {
                  init = 1;
                  Navigator.pop(context, Algorithm.Astar);
                  maze = new Maze(wall, isRandon);
                  setState(() {});
                  if (isRandon == true) {
                    showAlert(context);
                  } else {
                    helpingAlert(context);
                  }
                },
              )
            ],
          );
        });
  }

  void showAlert3(BuildContext context) async {
    showDialog<Algorithm>(
        context: context,
        barrierDismissible: true,
        builder: (context) => SimpleDialog(
              title: const Text('Please Select One'),
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () {
                    isRandon = true;
                    Navigator.pop(context, Algorithm.Astar);
                    showAlert2(context);
                  },
                  child: const Text('Randomly'),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    isRandon = false;
                    wall = 5;
                    Navigator.pop(context, Algorithm.Astar);
                    showAlert2(context);
                  },
                  child: const Text('Manually'),
                ),
              ],
            ));
  }

  Future<void> ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: (cost == null)
              ? Text(
                  'Failed',
                  style: TextStyle(color: Colors.red),
                )
              : Text(
                  'Success',
                  style: TextStyle(color: Colors.green),
                ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              (cost != null)
                  ? Container(
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5.0),
                      alignment: Alignment.centerLeft,
                      child: Text('Cost: ' + cost.toString()),
                    )
                  : Text(''),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
