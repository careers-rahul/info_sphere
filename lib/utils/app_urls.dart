class AppUrls {
  static const String mainUrl = "https://newsapi.org/v2";
  static const String apiKey = 'cf3a6f4ca76c49a4a5a357576888f6fb';

  //Categories
  static const String business = "$mainUrl/top-headlines?country=us&category=business";
  static const String worldNews = "$mainUrl/top-headlines?country=us";
  static const String sports = "$mainUrl/top-headlines?country=us&category=sports";
  static const String entertainment = "$mainUrl/top-headlines?country=us&category=entertainment";
  static const String technology = "$mainUrl/top-headlines?sources=techcrunch";
}
