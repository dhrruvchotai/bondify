import 'package:connectivity_plus/connectivity_plus.dart';

class Utility{

  Future<bool> isInternetAvailable () async{
    var connectivityResult = await Connectivity().checkConnectivity();

    if(connectivityResult[0] == ConnectivityResult.wifi){
      return true;
    }
    else if(connectivityResult[0] == ConnectivityResult.mobile){
      return true;
    }
    else{
      return false;
    }

  }
}