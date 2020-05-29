class Teacher{
  int _id;
  String _name;
  String _password;
  int _personId;
  String _phoneNumber;
  String _photoUrl;

  get id=>_id;
  get name=>_name;
  get password=>_password;
  get personId=>_personId;
  get phoneNumber=>_phoneNumber;
  get photoUrl=>_photoUrl;

  Teacher(int id, String name){
    this._id = id;
    this._name = name;
  }

 setId(int id){
   this._id = id;
 }
 setName(String name){
   this._name = name;
 }

  Teacher fromJson(String jsonString){
    
  }
}