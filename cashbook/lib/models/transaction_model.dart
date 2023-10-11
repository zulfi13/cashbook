class TransactionModel {
  int? id;
  String? date;
  int? nominal;
  String? description;
  String? category;

  TransactionModel({
    this.id,
    this.date,
    this.nominal,
    this.description,
    this.category,
  });

  transactionMap() {
    var mapping = <String, dynamic>{};
    mapping['id'] = id;
    mapping['date'] = date!;
    mapping['nominal'] = nominal!;
    mapping['description'] = description!;
    mapping['category'] = category!;
    return mapping;
  }
}
