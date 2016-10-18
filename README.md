# Cordova Banner Notifications

This plugin was created to implement a simple notification system for cordova on iOS 10.

## Supported Features:
- Title
- Body
- Trigger Time

## Sample
This notification will be triggered in 10 seconds.

```javascript
cordova.plugins.ios10.notification.schedule("MyApp", "New Notification!", 10.0);
```

## Supported Platforms:
- iOS 10

## Installation:
This plugin can be installed from CLI with either of the following:

```bash
cordova plugins add https://github.com/DavidBriglio/cordova-ios10-local-notification
```

##Future Development
- Implementing click action customization
- Add a carried payload by the notification (for action)
- Implement some of the new iOS 10 notification features
- Functionality to remove notifications

## Questions?
Please see the wiki for how to use the plugin.

Feel free to send me a message, open an issue, or make pull requests!


## License

This software is released under the MIT License.

David Briglio 2016.
