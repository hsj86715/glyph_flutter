class LearnAndPractise {
  int learnCount;
  int practiseCount;
  int practiseCorrect;
  int practiseBest;

  increaseLearn([int learn = 1]) {
    learnCount += learn;
  }

  increasePractise([int practise = 1, int correct = 0]) {
    practiseCount += practise;
    practiseCorrect += correct;
  }
}

class GlyphInfo extends LearnAndPractise {
  int id;
  String name;
  int nameId;
  String category;
  List<int> path;
  int pathId;
}
