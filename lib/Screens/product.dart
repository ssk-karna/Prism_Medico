class Product {
  const Product({
    this.name,
    this.pack,
    this.descr,
  });

  final String name;
  final int pack;
  final String descr;

  @override
  String toString() {
    return '$name ($pack)';
  }
}
