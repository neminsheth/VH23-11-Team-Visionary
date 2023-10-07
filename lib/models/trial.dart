class Prediction {
  final List<String> classes;
  final List<double> scores;

  Prediction({required this.classes, required this.scores});

  factory Prediction.fromJson(Map<String, dynamic> json) {
    List<String> classes = List<String>.from(json['predictions'][0]['classes']);
    List<double> scores = List<double>.from(json['predictions'][0]['scores']);
    return Prediction(classes: classes, scores: scores);
  }
}

class PredictionsResponse {
  final List<Prediction> predictions;

  PredictionsResponse({required this.predictions});

  factory PredictionsResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> predictionsJson = json['predictions'];
    List<Prediction> predictions = predictionsJson
        .map((predictionJson) => Prediction.fromJson(predictionJson))
        .toList();
    return PredictionsResponse(predictions: predictions);
  }
}

