import 'dart:async';

/// Waiting on a bloc to finish the work a pull-to-refresh kicked off.
extension BlocSettled<S> on Stream<S> {
  /// Completes on the first state satisfying [test] - or quietly, without
  /// throwing, if the bloc is closed or nothing arrives in time.
  ///
  /// Both of those happen in normal use and neither is an error:
  ///
  ///  * **The bloc closes first.** Popping a screen disposes its
  ///    [BlocProvider], which closes the bloc, which ends the stream. Plain
  ///    `firstWhere` on a stream that ends without a match throws
  ///    `StateError: No element` - so refreshing a page and immediately
  ///    backing out of it crashed. There is nothing left to wait for.
  ///  * **Nothing is emitted.** A response identical to what is already on
  ///    screen is a no-op `emit` that bloc drops, so a refresh can legitimately
  ///    produce no new state. Without the bound the caller's indicator would
  ///    stay open forever.
  ///
  /// Callers only ever await this to know when to retract an indicator, so
  /// swallowing both cases is the correct behaviour rather than a papered-over
  /// failure - the state itself is delivered by the BlocBuilder, not by this.
  Future<void> settled(
    bool Function(S state) test, {
    Duration timeout = const Duration(seconds: 20),
  }) async {
    try {
      await firstWhere(test).timeout(timeout);
    } on StateError {
      // Bloc closed - the screen that owned it is already gone.
    } on TimeoutException {
      // Nothing landed in time; let the caller stop waiting.
    }
  }
}
