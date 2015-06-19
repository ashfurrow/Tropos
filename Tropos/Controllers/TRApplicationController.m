@import CoreLocation;
#import "TRApplicationController.h"
#import "TRWeatherController.h"
#import "TRLocationController.h"

@implementation TRApplicationController

- (instancetype)init
{
    self = [super init];
    if (!self) { return nil; }

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.rootViewController = [storyboard instantiateInitialViewController];

    return self;
}

- (RACSignal *)performBackgroundFetch
{
    TRWeatherController *weatherController = [TRWeatherController new];

    return [weatherController.updateWeatherCommand execute:self];
}

- (void)setMinimumBackgroundFetchIntervalForApplication:(UIApplication *)application
{
    TRLocationController *locationController = [TRLocationController new];
    if ([locationController authorizationStatusEqualTo:kCLAuthorizationStatusAuthorizedAlways]) {
        [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
    } else {
        [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalNever];
    }
}

@end
