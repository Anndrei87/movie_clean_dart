class TrendingRequestParameters {
  final String language;
  final String locationLanguage;
  final int page;
  final String timeWindow;

  const TrendingRequestParameters(
      {required this.language,
      required this.locationLanguage,
      required this.page,
      required this.timeWindow});
}
