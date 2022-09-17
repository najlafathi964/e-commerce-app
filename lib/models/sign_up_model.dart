class SignUpModel {
  String name ;
  String email ;
  String phone ;
  String password ;

  SignUpModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password
  });

  Map<String , dynamic> toJson(){
    final Map<String,dynamic> data = Map<String ,dynamic>();
    data['f_name'] =this.name ;
    data['phone'] =this.phone ;
    data['email'] =this.email ;
    data['password'] =this.password ;

    return data ;

  }
}