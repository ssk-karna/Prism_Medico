class Utils{

  static String filterResponseString(String response){
    int startIndex = response.indexOf('{');
    return response.substring(startIndex);
  }
}