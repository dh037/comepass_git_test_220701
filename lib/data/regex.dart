class Regex {
  static RegExp passwordRule () => RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,20}$');

  // preg_match(‘/([a-z0-9].*[!,@,#,$,%,^,&,*,?,_,~,-])|([!,@,#,$,%,^,&,*,?,_,~,-].*[a-z0-9])/’, $txt)
  static RegExp nameRule () => RegExp(r'^[ㄱ-ㅎ|가-힣|a-z|A-Z]+$');

  static idRule() => RegExp(r'^[a-z]+[a-z0-9]{5,12}$');

  static birthRule() => RegExp(r'^(19[0-9][0-9]|20\d{2}) (0[0-9]|1[0-2]) (0[1-9]|[1-2][0-9]|3[0-1])$');

  static emailRule() => RegExp(r'^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$');

  static kioskRule() => RegExp(r'^[0-9]{4}$');

  static phone2Rule() => (r'^01([0|1|6|7|8|9]) ([0-9]{3,4}) ([0-9]{4})$');


}