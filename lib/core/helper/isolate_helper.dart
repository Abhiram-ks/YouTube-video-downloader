import 'dart:isolate';

class IsolateHelper {
  static Future<Isolate> run({
    required void Function(dynamic) worker,
    required dynamic data,
  }) async {
    return await Isolate.spawn(worker, data);
  }
}
