abstract class IReactiveButton {
  bool get buttonEnabled;
  Stream<bool> get buttonEnabledStream;
}
