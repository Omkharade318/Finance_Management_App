import 'money_manage.dart';

List<money> getterTop() {
  money upwork = money();
  upwork.name = 'upwork';
  upwork.fee = '- Rs 650';
  upwork.time = 'today';
  upwork.image = 'Education.png';
  upwork.buy = true;

  money starbucks = money();
  starbucks.buy = true;
  starbucks.fee = '- Rs 100';
  starbucks.image = 'Food.png';
  starbucks.name = 'starbucks';
  starbucks.time = 'yesterday';

  return [upwork, starbucks, starbucks];
}