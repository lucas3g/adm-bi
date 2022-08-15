abstract class ProjecaoEvents {}

class GetProjecaoEvent extends ProjecaoEvents {}

class ProjecaoFilterEvent extends ProjecaoEvents {
  final int ccusto;

  ProjecaoFilterEvent({required this.ccusto});
}
