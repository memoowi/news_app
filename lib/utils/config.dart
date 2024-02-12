class Config {
  static const String apiKey = 'c68c647cb10e49599d5125a9813c9303';
  static const String country = 'us';
  static String get urlHeadLines =>
      'https://newsapi.org/v2/top-headlines?country=$country&apiKey=$apiKey';
  static String get urlEverything =>
      'https://newsapi.org/v2/everything?apiKey=$apiKey&q=';
  static String get urlNoImages =>
      'https://www.its.ac.id/tmesin/wp-content/uploads/sites/22/2022/07/no-image.png';
}
