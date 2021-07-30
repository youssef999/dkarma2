import 'package:url_launcher/url_launcher.dart';

class Utils{

  static Future openLink({String url})=>_launchUrl(url);


  static Future _launchUrl(String url)async {
    if(await canLaunch(url)){
      await launch(url);
    }
  }
  static Future openEmail({String toEmail,String sub,String body
  })async
  {
    final url ='mailto:$toEmail?subject=${Uri.encodeFull(sub)}&body=${Uri.encodeFull(body)}';
    _launchUrl(url);
  }
}