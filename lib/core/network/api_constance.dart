class ApiConstance {
  static String baseUrl = "http://api.themoviedb.org/3//movie";
  static String apiKey = "?api_key=c3435cfe40aeb079689227d82bf921d3";
  static String getNowPlayingNetwork = "$baseUrl/now_playing$apiKey";
  static String getTopRatedNetwork = "$baseUrl/top_rated$apiKey";
  static String getPopularNetwork = "$baseUrl/popular$apiKey";
  static String imageUrl = "https://image.tmdb.org/t/p/w500";

  static String getDetailsNetwork(int movieId) => "$baseUrl/$movieId$apiKey";
  static String getRecommendationsNetwork(int movieId) => "$baseUrl/$movieId/recommendations$apiKey";


  static String image(String path) => "$imageUrl$path";
}
