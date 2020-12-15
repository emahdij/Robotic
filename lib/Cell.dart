import 'dart:math';

class Cell {
  int x;
  int y;
  int gcost;
  int hcost;
  int fcost;
  Cell parent = null;
  Cell(int y, int x) {
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

  int getGcost() {
    return this.gcost;
  }

  int getHcost() {
    return this.hcost;
  }

  int getFcost() {
    return this.fcost;
  }

  Cell getParent() {
    return this.parent;
  }

  void setGcost(int cost) {
    this.gcost = cost;
  }

  void setHcost(int cost) {
    this.hcost = cost;
  }

  void setFcost(int cost) {
    this.fcost = cost;
  }
}
