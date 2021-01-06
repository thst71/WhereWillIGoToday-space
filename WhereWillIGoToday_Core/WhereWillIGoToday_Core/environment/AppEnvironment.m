#import "AppEnvironment.h"


NSDate *convert(NSUInteger integer) {
    if (!integer) {
        return nil;
    }
    return [NSDate dateWithTimeIntervalSince1970:integer];;
}

void forward(Callback callback, NSObject *object, bool error) {

    if (!callback) {
        return;
    }
    Result *result = [Result resultWithData:object
                                    isError:error];

    callback(result);
}

NSString *notImplemented(NSObject *object, SEL sel) {
    return [NSString stringWithFormat:@"%@ in %@ not implemented",
                                      NSStringFromSelector(sel),
                                      object];
}


NSString *dkey(Class clazz) {
    if (!clazz) {
        return nil;
    }
    return NSStringFromClass(clazz);
}

NSString *string(id _object) {
    if (!_object) {
        return APP_EMPTY;
    }
    if ([_object isKindOfClass:[NSString class]]) {
        return _object;
    }
    //TODO Number, Date

    return [_object description];
}


NSString *path() {
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *file = [documents stringByAppendingPathComponent:@"plan.json"];
    return file;
}

NSString *pathToSettings() {
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *file = [documents stringByAppendingPathComponent:@"plan.json"];
    return file;
}
