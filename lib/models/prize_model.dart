class Prize {
  String id;
  String text;
  int price;
  bool isObtained;
  Prize(
      {required this.id,
      required this.text,
      this.isObtained = false,
      required this.price});
}
