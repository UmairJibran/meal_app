// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
// import 'package:hop/data/firebase/repository.dart';
// import 'package:firebase/version_users.firestore.g.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:bloc_provider/bloc_provider.dart';

// // States
// abstract class LoginState {}

// /// Not logged in or failed to login.
// class LoginStateNotLoggedIn extends LoginState {
//   final dynamic e;

//   LoginStateNotLoggedIn([this.e]);
// }

// /// Login in progress....
// class LoginStateLoggingIn extends LoginState {}

// /// Succeed to login but profile is not exist.
// class LoginStateNeedProfile extends LoginState {
//   final String userId;
//   final String lineNickname;
//   final String lineId;
//   final String lineAccessToken;

//   // nullable
//   final String lineThumbnailUrl;

//   LoginStateNeedProfile(this.userId, this.lineNickname, this.lineId,
//       this.lineAccessToken, this.lineThumbnailUrl)
//       : assert(userId != null),
//         assert(lineNickname != null);
// }

// /// Making profile.
// class LoginStateMakingProfile extends LoginState {
//   final String userId;
//   final String displayName;
//   final DateTime birthDay;
//   // final Gender gender;
//   final File profileImage;

//   LoginStateMakingProfile({
//     @required this.userId,
//     @required this.displayName,
//     @required this.birthDay,
//     // @required this.gender,
//     @required this.profileImage,
//   });
// }

// /// Succeed to login and have profile.
// class LoginStateLoggedIn extends LoginState {
//   // final User user;
//   final String userId;

//   LoginStateLoggedIn(this.userId, this.user)
//       : assert(userId != null),
//         assert(user != null);
// }

// // BLoC
// /// This BLoC will be living over some pages because login process needs multiple pages.
// class LoginPagesBloc implements BlocBase {
//   final AccountRepository _repository;

//   final BehaviorSubject<LoginState> _outCurrentStateController =
//       BehaviorSubject.seeded(LoginStateNotLoggedIn());

//   Stream<LoginState> get currentState => _outCurrentStateController.stream;

//   Stream<User> get currentUser =>
//       currentState.whereType<LoginStateLoggedIn>().map((s) => s.user);

//   Stream<bool> get inLoading => currentState.map((state) =>
//       state is LoginStateLoggingIn || state is LoginStateMakingProfile);

//   final StreamController<LoginActionTryLogin> _cmdCreateAccountController =
//       StreamController.broadcast();

//   StreamSink<LoginActionTryLogin> get createAccount =>
//       _cmdCreateAccountController.sink;

//   final StreamController<LoginActionMakeProfile> _cmdCreateProfileController =
//       StreamController.broadcast();

//   StreamSink<LoginActionMakeProfile> get createProfile =>
//       _cmdCreateProfileController.sink;

//   LoginPagesBloc(StreamSink<String> loginWithUserId, this._repository) {
//     _outCurrentStateController.stream
//         .whereType<LoginStateLoggedIn>()
//         .map((u) => u.userId)
//         .listen(loginWithUserId.add);

//     Rx.merge([
//       _cmdCreateAccountController.stream,
//       _cmdCreateProfileController.stream,
//     ])
//         .flatMap((action) =>
//             _transitStatesByActions(action, _outCurrentStateController.value))
//         .listen(_outCurrentStateController.add);
//   }

//   Stream<LoginState> _transitStatesByActions(
//       dynamic action, LoginState oldState) async* {
//     if (action is LoginActionTryLogin && oldState is LoginStateNotLoggedIn) {
//       yield LoginStateLoggingIn();
//       final loginResult = await _repository.login();
//       if (loginResult.hasAccount) {
//         yield LoginStateLoggedIn(
//             loginResult.hopUserId, loginResult.currentUser);
//       } else {
//         yield LoginStateNeedProfile(
//             loginResult.hopUserId,
//             loginResult.lineDisplayName,
//             loginResult.lineUserId,
//             loginResult.lineAccessToken,
//             loginResult.linePictureUrl);
//       }
//     } else if (action is LoginActionMakeProfile &&
//         oldState is LoginStateNeedProfile) {
//       yield LoginStateMakingProfile(
//         userId: oldState.userId,
//         displayName: action.displayName,
//         birthDay: action.birthDay,
//         // gender: action.gender,
//         profileImage: action.profileImage,
//       );
//       await _repository.saveProfile(
//           userId: oldState.userId,
//           displayName: action.displayName,
//           birthday: action.birthDay,
//           // gender: action.gender,
//           profileImage: action.profileImage,
//           lineNickname: oldState.lineNickname,
//           lineId: oldState.lineId,
//           lineAccessToken: oldState.lineAccessToken,
//           lineThumbnailImageUrl: oldState.lineThumbnailUrl);
//       yield LoginStateLoggedIn(oldState.userId,
//           await _repository.getCurrentUserPublicPart(userId: oldState.userId));
//     }
//   }

//   @override
//   void dispose() {
//     _outCurrentStateController.close();
//     _cmdCreateAccountController.close();
//     _cmdCreateProfileController.close();
//   }
// }

// // Actions

// class LoginActionTryLogin {}

// class LoginActionMakeProfile {
//   final String displayName;
//   final DateTime birthDay;
//   // final Gender gender;
//   final File profileImage;

//   LoginActionMakeProfile({
//     @required this.displayName,
//     @required this.birthDay,
//     // @required this.gender,
//     @required this.profileImage,
//   });
// }

// class LoginActionLoggedIn {
//   final String currentUserId;
//   final User user;

//   LoginActionLoggedIn(this.currentUserId, this.user) : assert(currentUserId != null && user != null);
// }

// class LoginActionLoginFailure {
//   final dynamic e;

//   LoginActionLoginFailure(this.e);
// }

// Repository

// class AccountRepository {
//   AccountRepository();

//   /// Try LINE login, throws StateError if failed to LINE login.
//   Future<LoginResult> login() async {
//     final lineLoginResult =
//         await LineSDK.instance.login(scopes: ["profile", "friends"]);
//     if (lineLoginResult.accessToken == null) {
//       throw StateError("Token from LINE isn't valid: $lineLoginResult");
//     }

//     final verificationResult = await VerifyToken.call(
//         lineLoginResult.userProfile.userId, lineLoginResult.accessToken.value);
//     final hopLoginResult = await FirebaseAuth.instance
//         .signInWithCustomToken(token: verificationResult.firebaseToken);

//     try {
//       final user =
//           await getCurrentUserPublicPart(userId: hopLoginResult.user.uid);
//       return LoginResult(true,
//           currentUser: user, hopUserId: hopLoginResult.user.uid);
//     } on NoSuchUserException catch (_) {
//       return LoginResult(false,
//           lineAccessToken: lineLoginResult.accessToken.value,
//           lineDisplayName: lineLoginResult.userProfile.displayName,
//           lineUserId: lineLoginResult.userProfile.userId,
//           linePictureUrl: lineLoginResult.userProfile.pictureUrl,
//           hopUserId: hopLoginResult.user.uid);
//     }
//   }

//   /// Try to fetch current logged in user, throws NoSuchUserException if user not exists.
//   Future<User> getCurrentUserPublicPart({String userId}) async {
//     if (userId == null) {
//       userId = await getCurrentUserId();
//     }

//     final user =
//         await DocumentAccessor().load<UserDocument>(UserDocument(id: userId));
//     if (user == null) {
//       throw NoSuchUserException(userId);
//     }
//     return user;
//   }

//   Future<SecureUser> getCurrentUserPrivatePart({String userId}) async {
//     if (userId == null) {
//       final user = await FirebaseAuth.instance.currentUser();
//       userId = user.uid;
//     }

//     final user = await DocumentAccessor()
//         .load<SecureUserDocument>(SecureUserDocument(id: userId));
//     if (user == null) {
//       throw NoSuchUserException(userId);
//     }
//     return user;
//   }

//   Stream<SecureUser> subscribeCurrentUserPrivatePart({String userId}) {
//     final uidStream = (userId != null)
//         ? Stream.value(userId)
//         : FirebaseAuth.instance.currentUser().then((u) => u.uid).asStream();
//     return uidStream.asyncExpand((userId) => SecureUserDocument(id: userId)
//         .reference
//         .snapshots()
//         .map((snapshot) => SecureUserDocument(snapshot: snapshot)));
//   }

//   /// Save and complete profile.
//   Future<void> saveProfile({
//     @required String userId,
//     @required String displayName,
//     @required DateTime birthday,
//     @required Gender gender,
//     @required File profileImage,
//     @required String lineId,
//     @required String lineAccessToken,
//     @required String lineNickname,
//     @required String lineThumbnailImageUrl,
//   }) async {
//     final profile = UserDocument(id: userId)
//       ..appealText = ""
//       ..birthday = Timestamp.fromDate(birthday)
//       ..description = ""
//       ..displayName = displayName
//       ..isSuspended = true
//       ..lineNickname = lineNickname
//       ..gender = gender;
//     profile.profileImages = [
//       await Storage().save("${profile.documentPath}/profileImage", profileImage)
//     ];
//     final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//     final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//     final privateData = SecureUserDocument(id: userId)
//       ..planStatus = PlanStatus.free
//       ..expirationIntent = null
//       ..fcmTokens = {androidInfo.androidId: await _firebaseMessaging.getToken()}
//       ..lineId = lineId
//       ..lineToken = lineAccessToken
//       ..subscribing = {"apple": {}, "google": {}};

//     await (Batch()..save(profile)..save(privateData)).commit();
//   }

//   Future<void> updateFcmToken(
//       SecureUserDocument privateData,
//   ) async {
//     final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//     final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//     final fcmToken = await _firebaseMessaging.getToken();
//     if (!privateData.fcmTokens.containsKey(androidInfo.androidId)){
//       privateData.fcmTokens.addAll({androidInfo.androidId:fcmToken});
//       final DocumentAccessor documentAccessor = DocumentAccessor();
//       await documentAccessor.update(privateData);
//     }
//   }

//   /// Fetch logged in user id
//   Future<String> getCurrentUserId() async {
//     final user = await FirebaseAuth.instance.currentUser();
//     return user.uid;
//   }

//   Future<bool> checkUpdate() async {
//     final packageInfo = await PackageInfo.fromPlatform();
//     final Version currentVersion = Version.parse(packageInfo.version);

//     final doc = await DocumentAccessor()
//         .load<ConfigurationDocument>(ConfigurationDocument(id: "android"));
//     final Version minimumVersion = Version.parse(doc.minimum_version);
//     if (currentVersion >= minimumVersion) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   /// To Check if a user is present, return false is not
//   Future<bool> isUserPresent() async {
//     final user = await FirebaseAuth.instance.currentUser();
//     return user != null;
//   }
// }
