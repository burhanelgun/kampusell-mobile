import 'package:kampusell/model/category.dart';

class PhotoValue {
  List<String> texts;
  List<String> labels;

  PhotoValue(this.texts, this.labels);

  Map<String, dynamic> toJson() =>
      {'texts': texts, 'labels': labels};
}
