
import 'package:finance/data/money_manage.dart';

List<money> getter(){
  money upwork = money();
  upwork.name = 'upwork';
  upwork.fee = 'Rs 650';
  upwork.time = 'today';
  upwork.image = 'Education.png';
  upwork.buy = false;

  money starbucks = money();
  starbucks.buy = true;
  starbucks.fee = 'Rs 100';
  starbucks.image = 'food.png';
  starbucks.name = 'starbucks';
  starbucks.time = 'yesterday';

  money transfer = money();
  transfer.buy = true;
  transfer.fee = 'Rs 50';
  transfer.image = 'Transfer.png';
  transfer.name = 'transfer';
  transfer.time = 'yesterday';

  return [upwork, starbucks, transfer, transfer, upwork, upwork, starbucks, transfer];
}