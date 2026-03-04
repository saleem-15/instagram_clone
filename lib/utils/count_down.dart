// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

class CountDown {
  /// count down time
  ///
  /// if you want to count for 10 seconds then =>
  /// ```dart
  ///   duration = Duration(seconds:10)
  /// ```

  final Duration countDownTime;
  Duration totalCountedTime = Duration.zero;

  /// when to call back [onPeriod]
  ///
  /// for example if [periodTimeCallBack] is 1 second then every 1 seconde [onPeriod]
  /// will be called until the  [totalCountedTime] finishes
  Duration periodTimeCallBack;

  /// used to know how much the timer has counted for this period
  ///
  /// its useful when resume the counter after pausing so the counter
  /// completes the period ''then'' starts a new period
  late Duration _periodTimeCounted;
  void Function()? onPeriod;

  /// called when the count down ends
  void Function()? onFinish;

  late Timer _timer;
  bool isStarted = false;
  late Stopwatch _stopwatch;
  Duration _countedTime = Duration.zero;

  CountDown({
    required this.countDownTime,
    required this.periodTimeCallBack,
    this.onPeriod,
    this.onFinish,
  });

  void startTimer() {
    assert(
      !isStarted,
      'The Counter Has Already Started!, Or it has finished try to create a new counter',
    );

    _stopwatch = Stopwatch()..start();
    _initTimer();
    isStarted = true;
  }

  void cancelCountDown() {
    _stopwatch.stop();
    _timer.cancel();
  }

  void pause() {
    _calculateCountedTime();
    _timer.cancel();
    _stopwatch.stop();
  }

  void resume() {
    assert(!_timer.isActive, 'Can\'t resume,Counter is already Active!');

    _stopwatch = Stopwatch()..start();

    _createTimerAfterResume();
  }

  void _createTimerAfterResume() {
    /// resume timer from where you stopped
    _timer = Timer.periodic(
      _periodTimeCounted,
      (timer) {
        _onTimerFinish(timer);

        _timer.cancel();
        _initTimer();
      },
    );
  }

  void _initTimer() {
    _timer = Timer.periodic(
      periodTimeCallBack,
      (timer) => _onTimerFinish(timer),
    );
  }

  /// this is called whenever [_timer] finishes, Not the count down
  ///
  /// basically every [periodTimeCallBack] duration finishes this method is called
  void _onTimerFinish(Timer timer) {
    _calculateCountedTime();

    totalCountedTime += periodTimeCallBack;

    log(_countedTime.inSeconds.toString());

    /// call onPeriod
    if (onPeriod != null) {
      onPeriod!();
    }

    /// if the countDown finishes then call onFinish
    if (totalCountedTime == countDownTime && onFinish != null) {
      _onCountDownFinsish();
    }
  }

  void _calculateCountedTime() {
    /// counted time from the last puase
    final c = _stopwatch.elapsed;

    _periodTimeCounted = Duration(microseconds: c.inMicroseconds % periodTimeCallBack.inMicroseconds);

    /// total counted time = counted time + counted time from the last puase
    _countedTime += c;
    _stopwatch.reset();
  }

  void _onCountDownFinsish() {
    /// call onFinish function (provided by the user)
    onFinish!();

    _timer.cancel();
    _stopwatch.stop();
    _countedTime = Duration.zero;
  }
}
