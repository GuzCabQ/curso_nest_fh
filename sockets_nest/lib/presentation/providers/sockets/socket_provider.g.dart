// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'socket_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$socketHash() => r'17e691e356eac7f659fa40584e6333ec1f277114';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef SocketRef = AutoDisposeProviderRef<Socket>;

/// See also [socket].
@ProviderFor(socket)
const socketProvider = SocketFamily();

/// See also [socket].
class SocketFamily extends Family<Socket> {
  /// See also [socket].
  const SocketFamily();

  /// See also [socket].
  SocketProvider call(
    String d,
  ) {
    return SocketProvider(
      d,
    );
  }

  @override
  SocketProvider getProviderOverride(
    covariant SocketProvider provider,
  ) {
    return call(
      provider.d,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'socketProvider';
}

/// See also [socket].
class SocketProvider extends AutoDisposeProvider<Socket> {
  /// See also [socket].
  SocketProvider(
    this.d,
  ) : super.internal(
          (ref) => socket(
            ref,
            d,
          ),
          from: socketProvider,
          name: r'socketProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$socketHash,
          dependencies: SocketFamily._dependencies,
          allTransitiveDependencies: SocketFamily._allTransitiveDependencies,
        );

  final String d;

  @override
  bool operator ==(Object other) {
    return other is SocketProvider && other.d == d;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, d.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$socketStatusHash() => r'9b2c8748581482baae072ecb379a6ddbde1ed4eb';

/// See also [SocketStatus].
@ProviderFor(SocketStatus)
final socketStatusProvider =
    AutoDisposeNotifierProvider<SocketStatus, ServerStatus>.internal(
  SocketStatus.new,
  name: r'socketStatusProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$socketStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SocketStatus = AutoDisposeNotifier<ServerStatus>;
String _$authJWTHash() => r'3b8929c7ceb617f5755f1413197f0792851a4162';

/// See also [AuthJWT].
@ProviderFor(AuthJWT)
final authJWTProvider = AutoDisposeNotifierProvider<AuthJWT, String>.internal(
  AuthJWT.new,
  name: r'authJWTProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authJWTHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthJWT = AutoDisposeNotifier<String>;
String _$isRunServerHash() => r'ce1fb09402e35728c1f34092c31d94077f4aa0a9';

/// See also [IsRunServer].
@ProviderFor(IsRunServer)
final isRunServerProvider =
    AutoDisposeNotifierProvider<IsRunServer, bool>.internal(
  IsRunServer.new,
  name: r'isRunServerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isRunServerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IsRunServer = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
