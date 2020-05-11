class User {
  int _id;
  String _username;
  String _password;
  String _fullName;
  String _accountNo;

  User(this._id,this._username, this._password,this._accountNo,this._fullName);
  User.fromMap(dynamic obj) {
    this._id = obj['_id'];
    this._username = obj['username'];
    this._password = obj['password'];
    this._fullName = obj['fullname'];
    this._accountNo = obj['account'];
  }
  String get username => _username;
  String get password => _password;
  String get fullname =>_fullName;
  String get account => _accountNo;
  int get id => _id;
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = _username;
    map["password"] = _password;
    map["fullname"] = _fullName;
    map["account"] = _accountNo;
    return map;
  }
}