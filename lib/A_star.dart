import 'dart:collection';
import 'dart:math';

import 'package:ai_p/Cell.dart';

class Astar {
  List lst = new List<List<int>>.generate(
      20, (i) => List<int>.generate(20, (j) => i * 20 + j));
  List visited = new List<List<bool>>.generate(
      20, (i) => List<bool>.generate(20, (j) => false));
  Cell start;
  Cell target;
  int cost = null;
  List<Cell> path = new List<Cell>();
  List<Cell> open_list = new List<Cell>();
  List<Cell> close_list = new List<Cell>();
  int left;
  int right;
  int down;
  int up;
  Astar(List lst, Cell start, Cell target, int up, int down, int right,
      int left) {
    this.lst = lst;
    this.start = Cell.distance(start.getY(), start.getX(), null);
    this.start.setFcost(0);
    this.target = Cell.distance(target.getY(), target.getX(), null);
    this.target.setFcost(0);
    this.left = left;
    this.right = right;
    this.up = up;
    this.down = down;
  }

  int search() {
    open_list.add(start);
    while (open_list.length > 0) {
      Cell current_node = open_list[0];
      int current_index = 0;

      for (int i = 0; i < open_list.length; i++) {
        if (open_list[i].getFcost() < current_node.getFcost()) {
          current_node = open_list[i];
          current_index = i;
        }
      }
      visited[current_node.getY()][current_node.getX()] = true;
      open_list.removeAt(current_index);
      close_list.add(current_node);
      if (current_node.getX() == target.getX() &&
          current_node.getY() == target.getY()) {
        Cell current = current_node;
        while (current != null) {
          path.add(current);
          current = current.getParent();
        }
        return current_node.getFcost();
      }
      List<Cell> neighbours = new List<Cell>();
      neighbours = getNeighbours(current_node);
      for (var neighbour in neighbours) {
        if (current_node.getX() - neighbour.getX() == 1)
          neighbour.setFcost(left + current_node.getFcost());
        else if (current_node.getX() - neighbour.getX() == -1)
          neighbour.setFcost(right + current_node.getFcost());
        else if (current_node.getY() - neighbour.getY() == 1)
          neighbour.setFcost(up + current_node.getFcost());
        else if (current_node.getY() - neighbour.getY() == -1)
          neighbour.setFcost(down + current_node.getFcost());
        for (var open in open_list)
          if (neighbour.getX() == open.getX() &&
              neighbour.getY() == open.getY() &&
              neighbour.getFcost() > open.getFcost()) continue;
        open_list.add(neighbour);
      }
    }
    return null;
  }

  List getNeighbours(Cell cell) {
    List<Cell> tmp = new List();
    int x = cell.getX();
    int y = cell.getY();
    if (!(x + 1 > 19)) if (!visited[y][x + 1]) if (lst[y][x + 1] != 1)
      tmp.add(new Cell.distance(y, x + 1, cell));
    if (!(y + 1 > 19)) if (!visited[y + 1][x]) if (lst[y + 1][x] != 1)
      tmp.add(new Cell.distance(y + 1, x, cell));
    if (!(x - 1 < 0)) if (!visited[y][x - 1]) if (lst[y][x - 1] != 1)
      tmp.add(new Cell.distance(y, x - 1, cell));
    if (!(y - 1 < 0)) if (!visited[y - 1][x]) if (lst[y - 1][x] != 1)
      tmp.add(new Cell.distance(y - 1, x, cell));
    return tmp;
  }

  List<Cell> getPath() {
    return path;
  }
}
