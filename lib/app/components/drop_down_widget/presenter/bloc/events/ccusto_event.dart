abstract class CCustoEvents {}

class GetCCustoEvent extends CCustoEvents {}

class ChangeCCustoEvent extends CCustoEvents {
  final int ccusto;

  ChangeCCustoEvent({required this.ccusto});
}
