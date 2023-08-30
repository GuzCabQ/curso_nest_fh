import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sockets_nest/presentation/providers/home/home_provider.dart';
import 'package:sockets_nest/presentation/providers/sockets/socket_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final socketStatus = ref.watch(socketStatusProvider);
    final home = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('WebSocket - Client'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.offline_bolt,
              color: socketStatus == ServerStatus.online
                  ? Colors.green
                  : Colors.red,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: home.input,
                      decoration: const InputDecoration(
                        labelText: 'JWT',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  FilledButton(
                      onPressed: () {
                        ref
                            .read(authJWTProvider.notifier)
                            .setAuth(home.input.text);
                      },
                      child: const Text('Login'))
                ],
              ),
              const Text('Connected'),
              Expanded(
                child: ListView.separated(
                  itemCount: home.clients.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, index) {
                    final client = home.clients[index];
                    return ListTile(
                        title: Column(
                      children: [Text(client)],
                    ));
                  },
                ),
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: home.messages.length,
                itemBuilder: (context, index) {
                  final message = home.messages[index];
                  return Container(
                      color: Colors.grey[300],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text(
                                  message.idFrom ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                  child: Text(
                                message.createdAt.toString(),
                                textAlign: TextAlign.right,
                              ))
                            ],
                          ),
                          Text(message.message)
                        ],
                      ));
                },
              )),
              const SizedBox(height: 20),
              TextFormField(
                controller: home.input,
                decoration: InputDecoration(
                  labelText: 'Message',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                      onPressed: () {
                        ref.read(homeProvider.notifier).sendMessage();
                      },
                      icon: const Icon(Icons.send)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
