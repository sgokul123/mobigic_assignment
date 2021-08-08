import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobigic_assignment/src/controller/grid_view_controller.dart';
import 'package:mobigic_assignment/src/utils/custom_color.dart';
import 'package:mobigic_assignment/src/widgets/input_fields.dart';

class GridViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut<GridViewController>(() => GridViewController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Game World'),
      ),
      body: GetX<GridViewController>(
          initState: (state) => Get.find<GridViewController>(),
          builder: (_controller) {
            return _controller.isSubmitted
                ? _buildGameBody(_controller)
                : ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        child: Form(
                          key: _controller.formKey,
                          autovalidateMode: _controller.validationAttempt == 0
                              ? AutovalidateMode.disabled
                              : AutovalidateMode.always,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
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
                                          nextFocus: _controller.columnFocus,
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
                                          firstFocus: _controller.columnFocus,
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
                                      _controller.displayGrid(
                                          _controller.alphabetsController.text);
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
    );
  }

  Widget _buildGameBody(GridViewController _controller) {
    int gridStateLength = _controller.columnCount;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
        Widget>[
      AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2.0)),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridStateLength,
            ),
            itemBuilder: _buildGridItems,
            itemCount: gridStateLength * gridStateLength,
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        child: InputFieldArea(
          hint: "Enter text to search",
          obscure: false,
          textEditingController: _controller.searchController,
          maxLength: 50,
          textAction: TextInputAction.done,
          onValueChanged: (newValue) {},
          onFieldError: (newFocus) {},
          firstFocus: _controller.searchFocus,
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
                    _controller.isSubmitted = false;
                  },
                  style: ElevatedButton.styleFrom(
                      primary: CustomColor.colorWhite,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      textStyle:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  child: Text("Find"),
                  onPressed: () {
                    if (_controller.searchController.text != null &&
                        _controller.searchController.text.toString().isNotEmpty)
                      _controller
                          .findTextInGrid(_controller.searchController.text);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: CustomColor.deepPurple,
                      padding: EdgeInsets.symmetric(vertical: 5),
                      textStyle:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ))
    ]);
    ;
  }

  Widget _buildGridItems(BuildContext context, int index) {
    int gridStateLength = Get.find<GridViewController>().gridState[0].length;
    int x, y = 0;
    x = (index / gridStateLength).floor();
    y = (index % gridStateLength);
    return GestureDetector(
      onTap: () => {},
      child: GridTile(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.5)),
          child: Container(
            child: Center(
              child: Text(
                Get.find<GridViewController>()
                    .gridState[x][y]
                    .title
                    .toString()
                    .toUpperCase(),
                style: TextStyle(
                    fontSize: 25.0,
                    color:
                        Get.find<GridViewController>().gridState[x][y].isValid
                            ? CustomColor.deepPurple
                            : CustomColor.textColorPrimary),
              ),
            ),
            color: Get.find<GridViewController>().gridState[x][y].isValid
                ? CustomColor.deepGreen
                : CustomColor.screenBackgroundColor,
          ),
        ),
      ),
    );
  }
}
