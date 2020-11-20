

class AppConfig{
  static String URL = "http://192.168.1.22:3000";

  static String URL_SIGNIN = URL + "/auth/login/";

  /* Post urls */
  static String URL_ALL_POSTS = URL + "/post/";
  static String URL_USER_POSTS = URL + "/post/find/";
  static String URL_LIKE_POST = URL + "/post/like/";
  static String URL_DISLIKE_POST = URL + "/post/dislike/";

  /* Comment urls */
  static String URL_POST_COMMENTS = URL + "/comment/find/";
  static String URL_LIKE_COMMENT = URL + "/comment/like/";
  static String URL_DISLIKE_COMMENT = URL + "/comment/dislike/";


  static String PROFILE_IMAGE_URL = URL + "/profile_images/";
  static String TRACK_URL = URL + "/tracks/";
}