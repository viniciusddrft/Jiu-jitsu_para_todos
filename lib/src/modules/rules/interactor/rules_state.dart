sealed class RulesState {
  const RulesState();
}

final class SuccessDownload extends RulesState {
  const SuccessDownload();
}

final class InitialRules extends RulesState {
  const InitialRules();
}

final class FailedDownload extends RulesState {
  final String message;

  const FailedDownload(this.message);
}

final class LoadingDownload extends RulesState {
  const LoadingDownload();
}
