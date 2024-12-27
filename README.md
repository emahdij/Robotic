# Path Planning Flutter Application 


## Overview 

This Flutter-based Path Planning application was developed as part of a university robotics project. The primary focus of this project is to demonstrate the implementation and efficiency of the A* (A-star) algorithm in navigating through obstacles to find the shortest path from a start point to a target.

## Features 
 
- **Interactive Grid:**  Users can manually set the start point, target, and walls or generate them randomly.
 
- **A* Algorithm Implementation:** Efficiently finds the shortest path considering different movement costs.
 
- **Customizable Costs:**  Each direction (up, down, left, right) can have different traversal costs, affecting the pathfinding outcome.

## Getting Started 

### Prerequisites 
 
- **Flutter SDK:**  Ensure you have Flutter installed. [Flutter Installation Guide](https://docs.flutter.dev/get-started/install)
 
- **Dart:**  Comes bundled with Flutter.

### Installation 
 
1. **Clone the Repository:** 

```bash
git clone https://github.com/emahdij/Robotic.git
```
 
2. **Navigate to the Project Directory:** 

```bash
cd robotic
```
 
3. **Install Dependencies:** 

```bash
flutter pub get
```
 
4. **Run the Application:** 

```bash
flutter run
```

## Usage 
 
1. **Choose Maze Configuration:**  
  - **Randomly:**  Generate a maze with a random distribution of walls.
 
  - **Manually:**  Place walls, start, and target points manually on the grid.
 
2. **Set Costs:** 
  - Adjust the traversal costs for each direction using the provided spin boxes.
 
3. **Run Pathfinding:** 
  - Start the A* algorithm to visualize the pathfinding process and view the final path and cost.

## Access the Application Online 

You can access the live version of this application on the web:
🌐 [Click Here](https://robotic.mehdijafarpour.ir/build/web/index.html) 
