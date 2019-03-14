enum RetroType {
  Start,
  Continue,
  Stop,
  Action
}

String getRetroTitle(RetroType type) {
  switch (type) {
    case RetroType.Start:
      return "Start doing";
    case RetroType.Continue:
      return "Continue doing";
    case RetroType.Stop:
      return "Stop doing";
    case RetroType.Action:
      return "Actions to take";
    default:
      return "";
  }
}