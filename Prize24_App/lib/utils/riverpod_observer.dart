import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final class RiverpodLogger extends ProviderObserver {
  final _logger = Logger(
    printer: PrettyPrinter(methodCount: 0, errorMethodCount: 5, lineLength: 50),
  );

  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    _logger.d(
      'Provider added: ${context.provider.name ?? context.provider.runtimeType}',
      error: {'value': value},
    );
    super.didAddProvider(context, value);
  }

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    _logger.i(
      'Provider updated: ${context.provider.name ?? context.provider.runtimeType}',
      error: {'previousValue': previousValue, 'newValue': newValue},
    );
    super.didUpdateProvider(context, previousValue, newValue);
  }

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    _logger.w(
      'Provider disposed: ${context.provider.name ?? context.provider.runtimeType}',
    );
    super.didDisposeProvider(context);
  }
}
