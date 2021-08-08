class GridItem {
  String title;
  bool isValid;

  GridItem({this.title, this.isValid});

  factory GridItem.fromJson(Map<String, dynamic> json) {
    return GridItem(
      title: json["title"],
      isValid: json["isValid"].toLowerCase() == 'true',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": this.title,
      "isValid": this.isValid,
    };
  }
//

}
