// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import './login1.dart';
// import 'package:provider/provider.dart';

// class _LoginPageViewModel {
//   final void Function() tryLogin;
//   final bool loading;

//   dynamic get error {
//     //    final state = _store.state;
//     //    return (state is LoginStateNotLoggedIn) ? state.e : null;
//   }

//   _LoginPageViewModel(this.tryLogin, this.loading)
//       : assert(tryLogin != null),
//         assert(loading != null);
// }

// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//           Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Image.asset("images/HOP.png"),
//               const Text("α1.0")
//             ],
//           ),
//           StreamBuilder<bool>(
//               stream: Provider.of<LoginPagesBloc>(context).inLoading,
//               builder: (context, snapshot) {
//                 final vm = _LoginPageViewModel(() {
//                   return Provider.of<LoginPagesBloc>(context)
//                       .createAccount
//                       .add(LoginActionTryLogin());
//                 }, snapshot.hasData && snapshot.data);

//                 if (vm.loading) {
//                   return const CircularProgressIndicator();
//                 } else {
//                   return RaisedButton(
//                     onPressed: vm.tryLogin,
//                     child: const Text("LINEでログイン"),
//                   );
//                 }
//               }),
//         ],
//       ),
//     );
//   }
// }
