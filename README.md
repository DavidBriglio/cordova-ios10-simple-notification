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

## Questions?

Please see the wiki for how to use the plugin.

Feel free to send me a message, open an issue, or make pull requests!

## License

This software is released under the MIT License.

David Briglio 2017.
