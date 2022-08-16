abstract class FormasPagEvents {}

class GetFormasPagEvent extends FormasPagEvents {}

class FilterFormasPag extends FormasPagEvents {
  final int ccusto;

  FilterFormasPag({
    required this.ccusto,
  });
}
