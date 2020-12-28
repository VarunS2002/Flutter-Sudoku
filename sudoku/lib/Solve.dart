import 'package:sudoku/Sudoku.dart';

class Solve {
  List<List<int>> solvedGrid;
  int counter = 0;

  Solve(List<List<int>> grid) {
    this.solvedGrid = grid;
    solve(solvedGrid);
  }

  List<List<int>> get solution {
    return solvedGrid;
  }

  int get noOfSolutions {
    return counter;
  }

  List<int> findEmpty(List<List<int>> grid) {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (grid[i][j] == 0) {
          return [i, j];
        }
      }
    }
    return null;
  }

  bool valid(List<List<int>> grid, int num, List<int> pos) {
    for (int i = 0; i < 9; i++) {
      if (grid[pos[0]][i] == num && pos[1] != i) {
        return false;
      }
    }
    for (int i = 0; i < 9; i++) {
      if (grid[i][pos[1]] == num && pos[0] != i) {
        return false;
      }
    }
    int boxX = pos[1] ~/ 3;
    int boxY = pos[0] ~/ 3;
    for (int i = boxY * 3; i < boxY * 3 + 3; i++) {
      for (int j = boxX * 3; j < boxX * 3 + 3; j++) {
        if (grid[i][j] == num && [i, j] != pos) {
          return false;
        }
      }
    }
    return true;
  }

  bool solve(List<List<int>> grid) {
    int row;
    int col;
    if (findEmpty(grid) == null) {
      counter++;
      return true;
    } else {
      row = findEmpty(grid)[0];
      col = findEmpty(grid)[1];
    }
    for (int i = 1; i < 10; i++) {
      if (valid(grid, i, [row, col])) {
        grid[row][col] = i;
        if (solve(grid)) {
          return true;
        }
        grid[row][col] = 0;
      }
    }
    return false;
  }
}

void main() {
  Sudoku test = new Sudoku("hard");
  Solve test2 = Solve(Sudoku.copyGrid(test.newSudoku));
  print(test.newSudokuSolved.toString() == test2.solution.toString());
}
