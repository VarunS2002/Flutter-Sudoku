import 'Solve.dart';

class Sudoku {
  int N = 9;
  int sqrN = 3;
  int K;
  List<List<int>> mat = new List.generate(
      9, (i) => [null, null, null, null, null, null, null, null, null]);
  List<List<int>> matSolved = new List.generate(
      9, (i) => [null, null, null, null, null, null, null, null, null]);

  Sudoku([String difficulty = 'easy']) {
    switch (difficulty) {
      case 'test':
        {
          this.K = 2;
        }
        break;
      case 'beginner':
        {
          this.K = 18;
        }
        break;
      case 'easy':
        {
          this.K = 27;
        }
        break;
      case 'medium':
        {
          this.K = 36;
        }
        break;
      case 'hard':
        {
          this.K = 54;
        }
        break;
    }
    fillValues();
  }

  static List<List<int>> copyGrid(List<List<int>> grid) {
    List<List<int>> copiedGrid = new List.generate(
        9, (i) => [null, null, null, null, null, null, null, null, null]);
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        copiedGrid[i][j] = grid[i][j];
      }
    }
    return copiedGrid;
  }

  void fillValues() {
    fillDiagonal();
    fillRemaining(0, sqrN);
    matSolved = copyGrid(mat);
    removeKDigits();
  }

  void fillDiagonal() {
    for (int i = 0; i < N; (i = (i + sqrN))) {
      fillBox(i, i);
    }
  }

  bool unUsedInBox(int rowStart, int colStart, int num) {
    for (int i = 0; i < sqrN; i++) {
      for (int j = 0; j < sqrN; j++) {
        if (mat[rowStart + i][colStart + j] == num) {
          return false;
        }
      }
    }
    return true;
  }

  void fillBox(int row, int col) {
    int num;
    for (int i = 0; i < sqrN; i++) {
      for (int j = 0; j < sqrN; j++) {
        do {
          num = randomGenerator();
        } while (!unUsedInBox(row, col, num));
        mat[row + i][col + j] = num;
      }
    }
  }

  static int randomGenerator() {
    List<int> numberList = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    numberList.shuffle();
    return numberList[0];
  }

  int randomGeneratorK() {
    List<int> numberList = new List<int>(81);
    for (int i = 0; i < N * N; i++) {
      numberList[i] = i;
    }
    numberList.shuffle();
    return numberList[0];
  }

  bool checkIfSafe(int i, int j, int num) {
    return (unUsedInRow(i, num) && unUsedInCol(j, num)) &&
        unUsedInBox(i - (i % sqrN), j - (j % sqrN), num);
  }

  bool unUsedInRow(int i, int num) {
    for (int j = 0; j < N; j++) {
      if (mat[i][j] == num) {
        return false;
      }
    }
    return true;
  }

  bool unUsedInCol(int j, int num) {
    for (int i = 0; i < N; i++) {
      if (mat[i][j] == num) {
        return false;
      }
    }
    return true;
  }

  bool fillRemaining(int i, int j) {
    if ((j >= N) && (i < (N - 1))) {
      i = (i + 1);
      j = 0;
    }
    if ((i >= N) && (j >= N)) {
      return true;
    }
    if (i < sqrN) {
      if (j < sqrN) {
        j = sqrN;
      }
    } else {
      if (i < (N - sqrN)) {
        if (j == ((i ~/ sqrN) * sqrN)) {
          j = (j + sqrN);
        }
      } else {
        if (j == (N - sqrN)) {
          i = (i + 1);
          j = 0;
          if (i >= N) {
            return true;
          }
        }
      }
    }
    for (int num = 1; num <= N; num++) {
      if (checkIfSafe(i, j, num)) {
        mat[i][j] = num;
        if (fillRemaining(i, j + 1)) {
          return true;
        }
        mat[i][j] = 0;
      }
    }
    return false;
  }

  void removeKDigits() {
    while (K > 0) {
      int row = randomGenerator() - 1;
      int col = randomGenerator() - 1;
      while (mat[row][col] == 0) {
        row = randomGenerator() - 1;
        col = randomGenerator() - 1;
      }
      int backup = mat[row][col];
      mat[row][col] = 0;
      List<List<int>> copy = copyGrid(mat);
      Solve test = Solve(copy);
      if (test.noOfSolutions != 1) {
        mat[row][col] = backup;
      }
      K--;
    }
    /*
    * Old function
    int count = K;
    while (count != 0)
    {
      int cellId = randomGeneratorK();
      int i = (cellId~/N);
      int j = cellId%9;
      if (j != 0)
        j = j - 1;

      if (mat[i][j] != 0)
      {
        count--;
        mat[i][j] = 0;
      }
    }
    */
  }

  List<List<int>> get newSudoku {
    return mat;
  }

  List<List<int>> get newSudokuSolved {
    return matSolved;
  }

  static void printSudoku(List<List<int>> mat) {
    for (List<int> row in mat) {
      print(row);
    }
  }
}

void main() {
  Sudoku test = new Sudoku("hard");
  Sudoku.printSudoku(test.newSudoku);
  print("");
  Sudoku.printSudoku(test.newSudokuSolved);
}
