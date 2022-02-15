import 'dart:async';

class Rx<T> implements StreamController<T> {
  late StreamController<T> _controller;
  late T? _value;
  late Object? _error;

  Rx([T? value]) {
    _controller = StreamController<T>.broadcast();

    if (value != null) {
      Future.delayed(const Duration(milliseconds: 100)).whenComplete(
        () => add(value),
      );
    }

    _value = value;
  }

  T? get value => _value;
  bool get hasError => _error != null;
  bool get hasValue => _value != null;

  @override
  FutureOr<void> Function()? onCancel;

  @override
  void Function()? onListen;

  @override
  void Function()? onPause;

  @override
  void Function()? onResume;

  @override
  void add(T event) {
    _controller.add(event);
    _value = event;
    _error = null;
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    _controller.addError(error, stackTrace);
    _error = error;
  }

  @override
  Future addStream(Stream<T> source, {bool? cancelOnError}) {
    return _controller.addStream(source, cancelOnError: cancelOnError);
  }

  @override
  Future close() {
    return _controller.close();
  }

  @override
  Future get done => _controller.done;

  @override
  bool get hasListener => _controller.hasListener;

  @override
  bool get isClosed => _controller.isClosed;

  @override
  bool get isPaused => _controller.isPaused;

  @override
  StreamSink<T> get sink => _controller.sink;

  @override
  Stream<T> get stream => _controller.stream;

  Stream<R> map<R>(R Function(T event) convert) {
    return _controller.stream.map(convert);
  }
}
