/*
 * cordova-ios10-local-notification
 * Created By David Briglio - 2016
 * https://github.com/DavidBriglio/cordova-ios10-local-notification
 * Created under the MIT License.
 *
 */

#import "iOS10Notification.h"
#import <Cordova/CDVPlugin.h>
@import UserNotifications;

@implementation iOS10Notification

//Show a local notification
- (void)schedule:(CDVInvokedUrlCommand*)command
{
    NSString* title = [command.arguments objectAtIndex:0];
    NSString* body = [command.arguments objectAtIndex:1];
    NSTimeInterval time = [[command.arguments objectAtIndex:2] doubleValue];

    //Make sure the time is positive
    if(time < 0.0) {
      time = 0.0;
    }

    //Return if there were invalid arguments
    if(title == nil || body == nil) {
        return;
    }

    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:title arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:body arguments:nil];
    content.sound = [UNNotificationSound defaultSound];

    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:time repeats:NO];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Notification" content:content trigger:trigger];
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];

    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert)
      completionHandler:^(BOOL granted, NSError * _Nullable error) {
                            if (error) {
                                NSLog(@"Request authorization failed!");
                            }
                        }];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"Notification failed!");
        }
    }];

}

@end
