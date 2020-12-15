import 'dart:math';

class Cell {
  int x;
  int y;
  int fcost;
  Cell parent = null;
  Cell(int y, int x) {
    this.x = x;
    this.y = y;
  }

  Cell.level(int y, int x, int level) {
    this.x = x;
    this.y = y;
  }
  Cell.distance(int y, int x, Cell parent) {
    this.x = x;
    this.y = y;
    this.parent = parent;
  }

  int getX() {
    return x;
  }

  int getY() {
    return y;
  }

  int getFcost() {
    return this.fcost;
  }

  Cell getParent() {
    return this.parent;
  }

  void setFcost(int cost) {
    this.fcost = cost;
  }
}
