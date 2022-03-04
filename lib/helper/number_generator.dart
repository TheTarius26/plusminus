import 'dart:math';

String randomGenerator(int range) {
  String randomString = "";
  Random random = Random();
  int randomNumber = random.nextInt(range);
  randomString = randomNumber.toString();
  return randomString;
}
