enum TipoTrofeu { ouro, prata, bronze, consolacao }

//TODO: Provisorio
extension TipoTrofeuExtension on TipoTrofeu {
  String get name => describeEnum(this);

  int get displayTitle {
    switch (this) {
      case TipoTrofeu.bronze:
        return 3;
      case TipoTrofeu.prata:
        return 2;
      case TipoTrofeu.ouro:
        return 1;
      default:
        return 0;
    }
  }

  String describeEnum(Object enumEntry) {
    final String description = enumEntry.toString();
    final int indexOfDot = description.indexOf('.');
    assert(
      indexOfDot != -1 && indexOfDot < description.length - 1,
      'The provided object "$enumEntry" is not an enum.',
    );
    return description.substring(indexOfDot + 1);
  }
}
