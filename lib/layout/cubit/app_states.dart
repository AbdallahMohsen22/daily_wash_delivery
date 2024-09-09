abstract class AppStates{}

class AppInitState extends AppStates{}
class ChangeIndexState extends AppStates{}
class EmitState extends AppStates{}
class ImagePicked extends AppStates{}
class ImageWrong extends AppStates{}
class GetCurrentLocationState extends AppStates{}

class LocationLoadingState extends AppStates{}
class LocationSuccessState extends AppStates{}

class OrderLoadingState extends AppStates{}
class OrderSuccessState extends AppStates{}
class OrderWrongState extends AppStates{}
class OrderErrorState extends AppStates{}

class BookOrderLoadingState extends AppStates{}
class BookOrderSuccessState extends AppStates{}
class BookOrderWrongState extends AppStates{}
class BookOrderErrorState extends AppStates{}

class ChangeOrderStatusLoadingState extends AppStates{}
class ChangeOrderStatusSuccessState extends AppStates{}
class ChangeOrderStatusWrongState extends AppStates{}
class ChangeOrderStatusErrorState extends AppStates{}
