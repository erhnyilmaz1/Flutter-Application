import 'dart:async';

Stream<int> getNumbers() async* {
  for (var i = 1; i < 5; i++) {
    yield i;
    yield i * 2;
    yield i * 3;
    await Future.delayed(const Duration(seconds: 1));

    // For OnError
    // if (i == 2) {
    //   throw Exception('Number Equal 2 Error.');
    // }
  }
}

// broadcast : Değer Değiştiğinde Tüm Stream'lere Değişen Değeri Verme İşlemini Sağlar.
StreamController<int> _controller = StreamController<int>.broadcast();
Stream<int> get _myStream => _controller.stream;
Sink<int> get _mySink => _controller.sink;

// Reactive Programming
void main(List<String> args) {
  // mainStreamListen();
  // subscriptionStreamListen();
  //streamMethods();
  //streamMethods2();
  streamControllerProcess();
}

void mainStreamListen() {
  getNumbers().listen((event) {
    print(event.toString());
  });
}

void subscriptionStreamListen() {
  var subscription = getNumbers().listen((event) {});
  // Success State
  subscription.onData((data) {
    print(data);
  });

  // Error State
  subscription.onError((error) {
    print(' Created Error :  $error');
  });

  // Always
  subscription.onDone(() {
    print('Stream Process Was Completed'); // Like finally
  });
}
void streamMethods() async {
  // asBroadcastStream : Değer Değiştiğinde Tüm Stream'lere Değişen Değeri Verme İşlemini Sağlar.
  var myStream = getNumbers().asBroadcastStream();

  myStream.listen((event) {
    print('1.listen $event');
  });

  myStream.listen((event) {
    print('2.listen $event');
  });

  print('First Usage: ' + (await myStream.first).toString());
  print('Last Usage: ' + (await myStream.last).toString());
  print('Length Usage: ' + (await myStream.length).toString());
  print('Single Usage: ' + (await myStream.single).toString());
  print('Contains Usage: ' + (await myStream.contains(3)).toString());
  print('ElementAt Usage: ' + (await myStream.elementAt(2)).toString());
  print('Any Usage: ' +
      (await myStream.any((element) => element == 2)).toString());
  print('Join Usage: ' + (await myStream.join(' ,')).toString());
}

void streamMethods2() {
  // asBroadcastStream : Değer Değiştiğinde Tüm Stream'lere Değişen Değeri Verme İşlemini Sağlar.
  var myStream = getNumbers().asBroadcastStream();

  myStream.expand((element) => [element, element * 2, 99]).listen((event) {
    print(event);
  });
  myStream.map((event) => event * 5).listen((event) {
    print(event);
  });
  myStream.where((event) => event % 2 == 0).listen((event) {
    print(event);
  });
  myStream.take(2).listen((event) {
    print(event);
  });
  myStream.skip(1).listen((event) {
    print(event);
  });
  myStream.distinct().listen((event) {
    print(event);
  });
}

void streamControllerProcess() {
  _myStream.listen((event) {
    print(event);
  });

  addItem();
}
void addItem() async {
  _mySink.add(5);
  await Future.delayed(Duration(seconds: 2));
  _mySink.add(10);
  await Future.delayed(Duration(seconds: 2));
  _mySink.add(15);
  await Future.delayed(Duration(seconds: 2));
}
