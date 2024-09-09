abstract class AuthStates {}

class AuthInitState extends AuthStates {}


class LoginLoadingState extends AuthStates {}
class LoginSuccessState extends AuthStates {}
class LoginWrongState extends AuthStates {}
class LoginErrorState extends AuthStates {}


class VerificationLoadingState extends AuthStates {}
class VerificationSuccessState extends AuthStates {}
class VerificationWrongState extends AuthStates {}
class VerificationErrorState extends AuthStates {}