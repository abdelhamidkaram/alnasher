class LoginRequest {
  final String email;
  final String password;

  LoginRequest({
    required this.password,
    required this.email,
  });

  toJson() => {'email': email, 'password': password};
}

class RegisterRequest {
  final String email;

  final String password;

  final String rePassword;

  final String lastName;

  final String firstName;

  RegisterRequest({
    required this.email,
    required this.password,
    required this.rePassword,
    required this.lastName,
    required this.firstName,
  });

  toJson() =>
      {'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'password_confirm': rePassword};
}

class VerifyCodeRequest{
  final String email ;
  final String code ;
  const VerifyCodeRequest({required this.email , required this.code });
  toJson()=>{
    'email':email,
    'code':code
  };

}

class ResetPasswordRequest{
  final String email ;
  final String code ;
  final String password ;
  final String confirmPassword ;
  const ResetPasswordRequest( {required this.password,required this.confirmPassword,required this.email , required this.code });
  toJson()=>{
    'email':email,
    'code':code,
    'password':password,
    'password_confirm':confirmPassword,
  };

}