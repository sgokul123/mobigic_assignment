import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobigic_assignment/src/models/grid_item.dart';

class GridViewController extends GetxController {
  TextEditingController rowsController = TextEditingController();
  TextEditingController columnController = TextEditingController();
  TextEditingController alphabetsController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  final _gridState =
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
    List<List<GridItem>> tempList = List.generate(
        rowCount, (i) => List.generate(columnCount, (j) => GridItem(title: "")),
        growable: false);
    if (text != null && text.isNotEmpty) {
      List strList = text.split("");
      int k = 0;
      for (int i = 0; i < rowCount; i++) {
        for (int j = 0; j < columnCount; j++) {
          tempList[i][j] = GridItem(title: strList[k], isValid: false);
          k++;
        }
      }
      this.gridState = tempList;
      this.isSubmitted = true;
    }
  }

  void findTextInGrid(String text) {
    List<List<GridItem>> tempList = List.generate(
        rowCount, (i) => List.generate(columnCount, (j) => GridItem(title: "")),
        growable: false);
    if (text != null && text.isNotEmpty) {
      List strList = text.split("");
      for (int k = 0; k < strList.length; k++) {
        for (int i = 0; i < rowCount; i++) {
          for (int j = 0; j < columnCount; j++) {
            if (strList[k] == _gridState[i][j].title) {
              tempList[i][j] = GridItem(title:  _gridState[i][j].title, isValid: true);
            } else {
              tempList[i][j] = GridItem(title:  _gridState[i][j].title, isValid: false);
            }
          }
        }
      }
      this.gridState = tempList;
      this.isSubmitted = true;
      update();
    }
  }
}
