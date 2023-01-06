enum Operation {
  add,
  subtract,
  multiply,
  divide;
}

extension Parse on Operation {
  String prefixString() {
    switch (this) {
      case Operation.add:
        return 'Adding';
      case Operation.subtract:
        return 'Subtracting';
      case Operation.multiply:
        return 'Multiplying';
      case Operation.divide:
        return 'Dividing';
      default:
        return '';
    }
  }

  String suffixString() {
    switch (this) {
      case Operation.add:
        return 'to';
      default:
        return 'by';
    }
  }
}
