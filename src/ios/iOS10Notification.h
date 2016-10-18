/*
 * cordova-ios10-local-notification
 * Created By David Briglio - 2016
 * https://github.com/DavidBriglio/cordova-ios10-local-notification
 * Created under the MIT License.
 *
 */

#import <Cordova/CDVPlugin.h>

@interface iOS10Notification : CDVPlugin

- (void)schedule:(CDVInvokedUrlCommand*)command;

@end
