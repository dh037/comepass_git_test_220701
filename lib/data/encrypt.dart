import 'package:encrypt/encrypt.dart';

final key = Key.fromUtf8('7WWQn3YcQOgKHxhVIL_KYKuIgFk2i2Ba');
final iv = IV.fromUtf8("n7CBIsYgpZcDMVVK");
final encryter = Encrypter(AES(key,mode: AESMode.cbc));

class Encrypt {

  String encrypt (String data){
    return encryter.encrypt(data,iv: iv).base64;
  }

  String decrypt (String data){
    return encryter.decrypt(Encrypted.fromBase64(data) , iv: iv);
  }


}