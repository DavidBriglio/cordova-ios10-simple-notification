# Cordova iOS10 Simple Notifications [![npm version](https://badge.fury.io/js/cordova-ios10-simple-notification.svg)](https://badge.fury.io/js/cordova-ios10-simple-notification)

This plugin was created to implement a simple and light-weight local notification system for cordova on iOS 10+.

## Supported Features:
- Contents: ID/Title/Subtitle/Body
- Trigger time (Seconds)
- Actions (Up to 4)
- Foreground notification support
- Body + Action click handling
- Notification payload in click handler

## Sample
These notifications will be triggered in 10 seconds.

```javascript
//No actions
cordova.plugins.ios10.simpleNotification.schedule("1", "Title", "Subtitle", "New Notification!", 10.0, "Payload");

//Two actions
cordova.plugins.ios10.simpleNotification.schedule("1", "Title", "Subtitle", "New Notification!", 10.0, "Payload", "Action 1", "Action 2");

//...

//Four actions max
cordova.plugins.ios10.simpleNotification.schedule("1", "Title", "Subtitle", "New Notification!", 10.0, "Payload", "Action 1", "Action 2", "Action 3", "Action 4");

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
