import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart';
part 'socket_provider.g.dart';

enum ServerStatus { online, offline, connecting }

@riverpod
Socket socket(SocketRef ref, String d) {
  final jwt = ref.watch(authJWTProvider);
  final isRunServer = ref.watch(isRunServerProvider);

  final socket = io(
      'http://localhost:3000/',
      OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .setExtraHeaders({'authentication': jwt})
          .build() // optional
      );
  return socket;
}

@riverpod
class SocketStatus extends _$SocketStatus {
  @override
  ServerStatus build() {
    // loadingServerStatus();
    return ServerStatus.connecting;
  }

  loadingServerStatus() {
    Socket socket = ref.watch(socketProvider(''));

    socket.onConnect((_) {
      debugPrint('connect client: ${socket.id}');
      state = ServerStatus.online;
    });
    socket.onDisconnect((_) {
      debugPrint('disconnect client: ${socket.id}');
      state = ServerStatus.offline;
    });
  }
}
//  {
//     'transports': ['websocket'],
//     'autoConnect': true
//   }

@riverpod
class AuthJWT extends _$AuthJWT {
  @override
  String build() {
    return '';
  }

  setAuth(String jwt) {
    ref.read(socketStatusProvider.notifier).loadingServerStatus();
    state = jwt;
  }
}

@riverpod
class IsRunServer extends _$IsRunServer {
  @override
  bool build() {
    return false;
  }

  setRunServer() {
    state = true;
  }
}
