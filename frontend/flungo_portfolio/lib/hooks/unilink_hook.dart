// if you wwant use uni_links package this will help
// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:uni_links/uni_links.dart';

// class _UniLinkHook extends Hook<void> {
//   final void Function(String?) callbackFunction;
//   const _UniLinkHook(this.callbackFunction);

//   @override
//   _UniLinkState createState() => _UniLinkState();
// }

// class _UniLinkState extends HookState<void, _UniLinkHook> {
//   late StreamSubscription _sub;

//   @override
//   void initHook() {
//     super.initHook();
//     _sub = linkStream.listen(hook.callbackFunction);
//   }

//   @override
//   void dispose() {
//     _sub.cancel();
//     super.dispose();
//   }

//   @override
//   void build(BuildContext context) {}
// }

// void useUniLinkHook(BuildContext context, void Function(String?) callback) {
//   return use(_UniLinkHook(callback));
// }
