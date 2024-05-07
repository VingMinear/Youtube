class FilterParam {
  String searchTxt = '';
  String startDate = '';
  String endDate = '';
  FilterParam({
    required this.searchTxt,
    required this.startDate,
    required this.endDate,
  });
  @override
  String toString() {
    return 'FilterParam{searchTxt: $searchTxt, startDate: $startDate, endDate: $endDate}';
  }
}
