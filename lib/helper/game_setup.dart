import 'dart:math';

int randomNumber() => Random().nextInt(1000);

int seedTableGenerator(int range) {
  Random random = Random();
  int randomNumber = random.nextInt(range);
  return randomNumber;
}

List<int> listCorrect(int point, int matrix) {
  List<int> list = [];
  int range = (point / 2).floor();
  int curatedPoint = point;
  Random random = Random();

  for (int i = 0; i < matrix; i++) {
    if (i + 1 == matrix) {
      list.add(curatedPoint);
      break;
    }
    int randomNumber = 0;
    if (curatedPoint < range) {
      randomNumber = random.nextInt(curatedPoint);
    } else {
      randomNumber = random.nextInt(range);
    }
    list.add(randomNumber);
    curatedPoint -= randomNumber;
  }

  return list;
}
