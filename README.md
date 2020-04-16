# Cordova iOS10 Simple Notifications [![npm version](https://badge.fury.io/js/cordova-ios10-simple-notification.svg)](https://badge.fury.io/js/cordova-ios10-simple-notification)

This plugin was created to implement a simple and light-weight local notification system for cordova on iOS 10+.

## Supported Features:

- Compatible with push plugins
- Contents: ID/Title/Subtitle/Body
- Trigger time (Seconds)
- Actions (Up to 4)
- Foreground notification support
- Body + Action click handling
- Notification payload in click handler

## Schedule Method

These notifications will be triggered in 10 seconds.

```javascript
// No actions
cordova.plugins.ios10.simpleNotification.schedule(
  "1",
  "Title",
  "Subtitle",
  "New Notification!",
  10.0,
  "Payload"
);

// Two actions
cordova.plugins.ios10.simpleNotification.schedule(
  "1",
  "Title",
  "Subtitle",
  "New Notification!",
  10.0,
  "Payload",
  "Action 1",
  "Action 2"
);

// ...

// Four actions max
cordova.plugins.ios10.simpleNotification.schedule(
  "1",
  "Title",
  "Subtitle",
  "New Notification!",
  10.0,
  "Payload",
  "Action 1",
  "Action 2",
  "Action 3",
  "Action 4"
);
```

| Parameter   | Type   | Description                                                                                                                                                                                          |
| ----------- | ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ID          | String | Identifier to show the notification. This can be used in the remove method when removing a specific notification.                                                                                    |
| Title       | String | Title of the notification.                                                                                                                                                                           |
| Subtitle    | String | Subtitle of the notification                                                                                                                                                                         |
| Message     | String | Message body of the notification                                                                                                                                                                     |
| Time        | Number | Timeout in seconds when to shedule the notification.                                                                                                                                                 |
| Payload     | String | String payload that will be passed to the click handler. This will be encoded/decoded through the callbacks, make sure you are using a string only (use JSON if you need to pass an object through). |
| Action (x4) | String | Name of the action button to show the user. This will be send to the click handler method along with the payload.                                                                                    |

## Register Method

If the user has not agreed to allow the app to show local notifications, we must prompt them for it.

```javascript
cordova.plugins.ios10.simpleNotification.register();
```

## Set Delegate Method

> _Ignore if not using a push plugin._

This method will set this plugin as the notification delegate. This means that the plugin will handle all notification clicks and notification scheduling. This method is called automatically upon success of the `register` method, and again every time the `schedule` method is called. This method exists in case there are any timing conflicts with a push plugin setting itself as the delegate, so that we can force setting the delegate manually.

```javascript
cordova.plugins.ios10.simpleNotification.setDelegate();
```

## Set Handler Method

Set the callback that will be triggered when clicking on the notification (or notification actions). This will be given the `action` string that was clicked on (`com.apple.UNNotificationDefaultActionIdentifier` if body has been clicked), and the string payload `provided` in the schedule method.

```javascript
cordova.plugins.ios10.simpleNotification.setHandler((action, payload) =>
  handlePayload(payload)
);
```

## Remove notifications

Specify ID of notification to remove

```javascript
cordova.plugins.ios10.simpleNotification.remove("ID");
```

## Supported Platforms:

- iOS 10.0+

## Installation:

This plugin can be installed from CLI with either of the following:

```bash
# Latest npm release
cordova plugins add cordova-ios10-simple-notification

# or

# Github master
cordova plugins add https://github.com/DavidBriglio/cordova-ios10-simple-notification
```

## Interaction With Push Plugins

> _Ignore if not using a push plugin._

There are two things that are of concern when using this plugin with a push plugin:

1. Notification Scheduling
2. Notification Clicks

### 1. Notification Scheduling

This plugin contains a handler for showing notifications. With all local notifications it will show as normal, and pass any push notifications it receives along without any sound / vibration / notification.

### 2. Notification Clicks

iOS only allows for one click handler to be registered for all notifications. Whichever plugin registers itself as the current notification click handler most recently will be the plugin that will hanlde the click. For this reason, this plugin assigns itself as the click handler upon every local notification schedule. This way the plugin will always handle all notification clicks (local and push).

Because of this behaviour, you must add your push notification click handling logic within whatever method you register as the click handler for this plugin. That way you can handle both local and push notification click payloads.

Please also note that this behaviour will only start once one of the following methods has been called:

- `register()` (with success)
- `setDelegate()`
- `schedule()` (delegate set on each call)

The plugin will not handle notification clicks until the plugin is set as the delegate for notifications. Also be aware of when the push plugin you are using sets the delegate to itself. Make sure you understand this logic or else you may not be handling both local and push clicks properly.

## Questions?

Please see the wiki for how to use the plugin.

Feel free to send me a message, open an issue, or make pull requests!

## License

This software is released under the MIT License.

David Briglio 2017.
