import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobigic_assignment/src/models/grid_item.dart';
import 'package:mobigic_assignment/src/utils/custom_logger.dart';

class GridViewController extends GetxController {
  TextEditingController rowsController = TextEditingController();
  TextEditingController columnController = TextEditingController();
  TextEditingController alphabetsController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  final _gridState =
      List.generate(0, (i) => List.generate(0, (j) => GridItem(title: ""))).obs;
  List<List<GridItem>> tempGridList =
      List.generate(0, (i) => List.generate(0, (j) => GridItem(title: ""))).obs;
  FocusNode rowFocus = FocusNode();
  FocusNode columnFocus = FocusNode();
  FocusNode alphabetFocus = FocusNode();
  FocusNode searchFocus = FocusNode();
  final _validationAttempt = 0.obs;
  final _rowCount = 0.obs;
  final _columnCount = 0.obs;
  final _alphabetCount = 1.obs;
  final _isSubmitted = false.obs;
  var formKey = GlobalKey<FormState>();

  get gridState => this._gridState.value;

  set gridState(value) => this._gridState.assignAll(value);

  get columnCount => this._columnCount.value;

  set columnCount(value) => this._columnCount.value = value;

  get rowCount => this._rowCount.value;

  set rowCount(value) => this._rowCount.value = value;

  get validationAttempt => this._validationAttempt.value;

  set validationAttempt(value) => this._validationAttempt.value = value;

  get alphabetCount => this._alphabetCount.value;

  set alphabetCount(value) => this._alphabetCount.value = value;

  get isSubmitted => this._isSubmitted.value;

  set isSubmitted(value) => this._isSubmitted.value = value;

  void setTextCount() {
    int row = 0;
    int column = 0;
    if (rowsController.text != null &&
        rowsController.text.toString().trim().length > 0) {
      row = int.parse(rowsController.text);
    }
    if (columnController.text != null &&
        columnController.text.toString().trim().length > 0) {
      column = int.parse(columnController.text);
    }
    if (row > 0 && column > 0) {
      rowCount = row;
      columnCount = column;
      alphabetCount = row * column;
    } else if (column > 0) {
      alphabetCount = column;
      columnCount = column;
    } else if (row > 0) {
      rowCount = row;
      alphabetCount = row;
    }
  }

  void displayGrid(String text) {
    this.gridState =
        List.generate(0, (i) => List.generate(0, (j) => GridItem(title: "")));
    tempGridList = List.generate(
        rowCount, (i) => List.generate(columnCount, (j) => GridItem(title: "")),
        growable: false);
    if (text != null && text.isNotEmpty) {
      List strList = text.split("");
      int k = 0;
      for (int i = 0; i < rowCount; i++) {
        for (int j = 0; j < columnCount; j++) {
          tempGridList[i][j] = GridItem(title: strList[k], isValid: false);
          k++;
        }
      }
      this.gridState = tempGridList;
      this.isSubmitted = true;
    }
  }

  static List<int> x = [-1, -1, -1, 0, 0, 1, 1, 1];
  static List<int> y = [-1, 0, 1, -1, 1, -1, 0, 1];
  static int R, C;
  List<List<Item>> listOfList =
      List.generate(0, (i) => List.generate(0, (j) => Item(0, 0)));

  static List<Item> search2D(
      List<List<GridItem>> grid, int row, int col, String word) {
    List<Item> listMAp = List.empty(growable: true);
    List strList = word.split("");
    listMAp.add(Item(row, col));
    if (grid[row][col].title.toUpperCase() != strList[0].toUpperCase())
      return null;
    int len = strList.length;
    for (int dir = 0; dir < 8; dir++) {
      int k, rd = row + x[dir], cd = col + y[dir];
      for (k = 1; k < len; k++) {
        if (rd >= R || rd < 0 || cd >= C || cd < 0) break;
        if (grid[rd][cd].title.toUpperCase() != strList[k].toUpperCase()) break;
        CustomLogger.log("pattern found dir$dir $rd col $cd");
        listMAp.add(Item(rd, cd));
        rd += x[dir];
        cd += y[dir];
      }
      CustomLogger.log("pattern is found $k");
      if (k == len) return listMAp;
    }
    return null;
  }

  void patternSearch(List<List<GridItem>> grid, String word) {
    for (int row = 0; row < R; row++) {
      for (int col = 0; col < C; col++) {
        List<Item> listMAp = search2D(grid, row, col, word);
        if (listMAp != null && listMAp.length > 0) {
          listOfList.add(listMAp);
        }
      }
    }
    if (listOfList != null && listOfList.length > 0) {
      List<List<GridItem>> tempList = tempGridList;
      print("  ${listOfList.length}");
      for (int l = 0; l < listOfList.length; l++) {
        List<Item> listMAp = listOfList[l];
        for (Item item in listMAp) {
          CustomLogger.log("tempList ${item.row} ${item.col} ");
          tempList[item.row][item.col].isValid = true;
        }
      }
      this.gridState = tempList;
    }
  }

  void findTextInGrid(String text) {
    R = rowCount;
    C = columnCount;
    listOfList.clear();
    patternSearch(_gridState, text);
  }

  printList() {
    int k = 0;
    for (int i = 0; i < rowCount; i++) {
      for (int j = 0; j < columnCount; j++) {
        CustomLogger.log("GridItem ${_gridState[i][j]}");
        k++;
      }
    }
  }

  void clearList() {
    this.isSubmitted = false;
    searchController.text = "";
    alphabetsController.text = "";
    this.gridState =
        List.generate(0, (i) => List.generate(0, (j) => GridItem(title: "")));
    tempGridList =
        List.generate(0, (i) => List.generate(0, (j) => GridItem(title: "")));
  }

  ///Clear Screen data as per screen display
  void clearSearch() {
    if (isSubmitted) {
      displayGrid(alphabetsController.text);
      searchController.text = "";
      searchFocus.requestFocus();
    } else {
      rowsController.text = "";
      columnController.text = "";
      alphabetsController.text = "";
      rowFocus.requestFocus();
      rowCount = 0;
      columnCount = 0;
      alphabetCount = 1;
    }
  }
}

class Item {
  int row, col;

  Item(this.row, this.col);
}
