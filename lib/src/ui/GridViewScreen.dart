import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobigic_assignment/src/controller/grid_view_controller.dart';
import 'package:mobigic_assignment/src/utils/custom_color.dart';
import 'package:mobigic_assignment/src/widgets/input_fields.dart';

class GridViewScreen extends StatelessWidget {
  GridViewController controller;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<GridViewController>(() => GridViewController());
    controller = Get.find<GridViewController>();
    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Game World'),
            leading: null,
            actions: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: OutlinedButton(
                  child: Text("Clear"),
                  style: OutlinedButton.styleFrom(
                    primary: CustomColor.colorWhite,
                    side: BorderSide(color: CustomColor.colorWhite, width: 1),
                  ),
                  onPressed: () {
                    controller.clearSearch();
                  },
                ),
              ),
            ],
          ),
          body: GetX<GridViewController>(
              initState: (state) => Get.find<GridViewController>(),
              builder: (_controller) {
                return _controller.isSubmitted
                    ? _buildGameBody()
                    : ListView(
                        shrinkWrap: true,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Form(
                              key: _controller.formKey,
                              autovalidateMode:
                                  _controller.validationAttempt == 0
                                      ? AutovalidateMode.disabled
                                      : AutovalidateMode.always,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: InputFieldArea(
                                              hint: "Rows count",
                                              obscure: false,
                                              textEditingController:
                                                  _controller.rowsController,
                                              maxLength: 1,
                                              minLength: 1,
                                              textAction: TextInputAction.next,
                                              onValueChanged: (newValue) {},
                                              onFieldError: (newFocus) {},
                                              firstFocus: _controller.rowFocus,
                                              nextFocus:
                                                  _controller.columnFocus,
                                              inputType: TextInputType.number,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: InputFieldArea(
                                              hint: "Column count",
                                              obscure: false,
                                              textEditingController:
                                                  _controller.columnController,
                                              maxLength: 1,
                                              minLength: 1,
                                              textAction: TextInputAction.done,
                                              onValueChanged: (newValue) {
                                                _controller.setTextCount();
                                              },
                                              onFieldError: (newFocus) {},
                                              firstFocus:
                                                  _controller.columnFocus,
                                              inputType: TextInputType.number,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    InputFieldArea(
                                      hint: "Enter Alphabets to display",
                                      obscure: false,
                                      textEditingController:
                                          _controller.alphabetsController,
                                      maxLength: _controller.alphabetCount,
                                      minLength: _controller.alphabetCount,
                                      textAction: TextInputAction.done,
                                      onValueChanged: (newValue) {
                                        _controller.setTextCount();
                                      },
                                      onFieldError: (newFocus) {},
                                      firstFocus: _controller.alphabetFocus,
                                      inputType: TextInputType.text,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton(
                                      child: Text("Show"),
                                      onPressed: () {
                                        if (_controller.formKey.currentState
                                            .validate()) {
                                          _controller.displayGrid(_controller
                                              .alphabetsController.text);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          primary: CustomColor.deepPurple,
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          textStyle: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
              }),
        ),
      ),
    );
  }

  ///Build Grid view and search view to search text in Grid
  Widget _buildGameBody() {
    int gridStateLength = controller.columnCount;
    int gridRowLength = controller.rowCount;
    return ListView(
      shrinkWrap: true,
      children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2.0)),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      childAspectRatio: gridRowLength / gridStateLength,
                      maxCrossAxisExtent: 400/gridStateLength,
                      crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                    ),
                    itemBuilder: _buildGridItems,
                    itemCount: gridRowLength * gridStateLength,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, left: 15.0, right: 15.0),
                child: InputFieldArea(
                  hint: "Enter text to search",
                  obscure: false,
                  textEditingController: controller.searchController,
                  maxLength: 50,
                  textAction: TextInputAction.done,
                  onValueChanged: (newValue) {},
                  onFieldError: (newFocus) {},
                  firstFocus: controller.searchFocus,
                  inputType: TextInputType.text,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: ElevatedButton(
                          child: Padding(
                              padding: EdgeInsets.only(left: 15.0, right: 15.0),
                              child: Text(
                                "Back",
                                style: TextStyle(color: CustomColor.deepPurple),
                              )),
                          onPressed: () {
                            controller.clearList();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: CustomColor.colorWhite,
                              padding: EdgeInsets.symmetric(vertical: 5),
                              textStyle: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          child: Text("Find"),
                          onPressed: () {
                            if (controller.searchController.text != null &&
                                controller.searchController.text
                                    .toString()
                                    .isNotEmpty) {
                              controller.findTextInGrid(
                                  controller.searchController.text);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: CustomColor.deepPurple,
                              padding: EdgeInsets.symmetric(vertical: 5),
                              textStyle: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ))
            ]),
      ],
    );
  }

  ///Display Alphabets in Grid as user entered
  Widget _buildGridItems(BuildContext context, int index) {
    int gridStateLength = controller.columnCount;
    int x, y = 0;
    x = (index / gridStateLength).floor();
    y = (index % gridStateLength);
    return Obx(() => Visibility(
          visible:
              controller.gridState != null && controller.gridState.length > 0,
          child: GestureDetector(
            onTap: () => {
              controller.printList(),
            },
            child: GridTile(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.5)),
                child: Container(
                  child: Center(
                    child: Text(
                      controller.gridState[x][y].title.toString().toUpperCase(),
                      style: TextStyle(
                          fontSize: 25.0,
                          color: controller.gridState[x][y].isValid
                              ? CustomColor.deepPurple
                              : CustomColor.textColorPrimary),
                    ),
                  ),
                  color: controller.gridState[x][y].isValid
                      ? CustomColor.deepGreen
                      : CustomColor.screenBackgroundColor,
                ),
              ),
            ),
          ),
        ));
  }
}
