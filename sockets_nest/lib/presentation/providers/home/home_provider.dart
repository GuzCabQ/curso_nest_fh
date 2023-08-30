import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:sockets_nest/presentation/providers/sockets/socket_provider.dart';
import 'dart:convert';
part 'home_provider.g.dart';

@riverpod
class Home extends _$Home {
  Socket get socket => ref.watch(socketProvider('ABC'));
  @override
  HomeController build() {
    loadSocket();
    return HomeController();
  }

  loadSocket() {
    loadClients();
    loadMessages();
  }

  loadClients() {
    socket.on('clients-updated', (data) {
      if (data is List) {
        final a = data.map((e) => e.toString()).toList();
        state = state.copyWith(clients: a);
      }
    });
  }

  loadMessages() {
    socket.on('message-from-server', (data) {
      state = state.copyWith(
        messages: [...state.messages, Messages.fromJson(data)],
      );
    });
  }

  sendMessage() {
    if (state.input.text.isEmpty) return;
    final message = Messages(
        idFrom: socket.id,
        message: state.input.text,
        createdAt: DateTime.now());

    state = state.copyWith(
      messages: [
        ...state.messages,
        message,
      ],
    );

    socket.emit('message-from-client', {
      'idFrom': message.idFrom,
      'message': message.message,
      'createdAt': message.createdAt.toIso8601String(),
    });
  }
}

class HomeController {
  final List<String> clients;
  final List<Messages> messages;
  final input = TextEditingController();

  HomeController({List<String>? clients, List<Messages>? messages})
      : clients = clients ?? [],
        messages = messages ?? [];

  HomeController copyWith({
    List<String>? clients,
    List<Messages>? messages,
  }) {
    return HomeController(
      clients: clients ?? this.clients,
      messages: messages ?? this.messages,
    );
  }
}

Messages messageFromJson(String str) => Messages.fromJson(json.decode(str));

String messageToJson(Messages data) => json.encode(data.toJson());

class Messages {
  String? idFrom;
  String? idTo;
  String message;
  DateTime createdAt;

  Messages({
    this.idFrom,
    this.idTo,
    required this.message,
    required this.createdAt,
  });

  factory Messages.fromJson(Map<String, dynamic> json) => Messages(
        idFrom: json["idFrom"],
        idTo: json["idTo"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "idFrom": idFrom,
        "idTo": idTo,
        "message": message,
        "createdAt": createdAt.toIso8601String(),
      };
}
