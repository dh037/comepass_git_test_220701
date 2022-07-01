class MemberRegist {
  String? userNm;
  String? userEmail;
  String? userPhone;
  String? userBirth;
  String? userGender;
  String? pinCode;
  String? authCode;
  String? userId;
  String? userPw;
  String? zipcode;
  String? address1;
  String? address2;
  String? platform;
  String? platformId;
  String? parentNm;
  String? parentPhone;
  String? parentAlarm;
  Alrams? alrams;

  MemberRegist(
      {this.userNm,
        this.userEmail,
        this.userPhone,
        this.userBirth,
        this.userGender,
        this.pinCode,
        this.authCode,
        this.userId,
        this.userPw,
        this.zipcode,
        this.address1,
        this.address2,
        this.platform,
        this.platformId,
        this.parentNm,
        this.parentPhone,
        this.parentAlarm,
        this.alrams});

  MemberRegist.fromJson(Map<String, dynamic> json) {
    userNm = json['user_nm'];
    userEmail = json['user_email'];
    userPhone = json['user_phone'];
    userBirth = json['user_birth'];
    userGender = json['user_gender'];
    pinCode = json['pin_code'];
    authCode = json['auto_code'];
    userId = json['user_id'];
    userPw = json['user_pw'];
    zipcode = json['zipcode'];
    address1 = json['address1'];
    address2 = json['address2'];
    platform = json['platform'];
    platformId = json['platform_id'];
    parentNm = json['parent_nm'];
    parentPhone = json['parent_phone'];
    parentAlarm = json['parent_alarm'];
    alrams =
    json['alrams'] != null ? new Alrams.fromJson(json['alrams']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_nm'] = this.userNm;
    data['user_email'] = this.userEmail;
    data['user_phone'] = this.userPhone;
    data['user_birth'] = this.userBirth;
    data['user_gender'] = this.userGender;
    data['pin_code'] = this.pinCode;
    data['auto_code'] = this.authCode;
    data['user_id'] = this.userId;
    data['user_pw'] = this.userPw;
    data['zipcode'] = this.zipcode;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['platform'] = this.platform;
    data['platform_id'] = this.platformId;
    data['parent_nm'] = this.parentNm;
    data['parent_phone'] = this.parentPhone;
    data['parent_alarm'] = this.parentAlarm;
    if (this.alrams != null) {
      data['alrams'] = this.alrams!.toJson();
    }
    return data;
  }
}

class Alrams {
  List<int>? required;
  List<int>? optional;

  Alrams({this.required, this.optional});

  Alrams.fromJson(Map<String, dynamic> json) {
    required = json['required'].cast<int>();
    optional = json['optional'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['required'] = this.required;
    data['optional'] = this.optional;
    return data;
  }
}
