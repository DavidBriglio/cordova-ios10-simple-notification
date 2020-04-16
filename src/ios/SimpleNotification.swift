import UserNotifications

@available(iOS 10, *)
@objc(SimpleNotification) class SimpleNotification : CDVPlugin, UNUserNotificationCenterDelegate {

  @objc(schedule:)
  func schedule(command: CDVInvokedUrlCommand) {
    //Set the result as error in case something fails
    var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)

    //Get all information for the notification
    let id = command.arguments[0] as? String ?? ""
    let title = command.arguments[1] as? String ?? ""
    let subtitle = command.arguments[2] as? String ?? ""
    let body = command.arguments[3] as? String ?? ""
    var timetrigger = command.arguments[4] as? Double ?? 0.001
    let payload = command.arguments[5] as? String ?? ""
    let actionText1 = command.arguments[6] as? String ?? ""
    let actionText2 = command.arguments[7] as? String ?? ""
    let actionText3 = command.arguments[8] as? String ?? ""
    let actionText4 = command.arguments[9] as? String ?? ""

    //Make sure that the trigger time is slightly above 0 (having it at 0 causes issues)
    if (timetrigger < 0.001) {
      timetrigger = 0.001
    }

    //Set the trigger time according to what the input was
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timetrigger, repeats: false)

    //Set the notification actions
    var actions = [UNNotificationAction]()

    if (actionText1 != "") {
      actions.append(UNNotificationAction(identifier: actionText1, title: actionText1, options: []))
    }

    if (actionText2 != "") {
      actions.append(UNNotificationAction(identifier:actionText2, title: actionText2, options: []))
    }

    if (actionText3 != "") {
      actions.append(UNNotificationAction(identifier:actionText3, title: actionText3, options: []))
    }

    if (actionText4 != "") {
      actions.append(UNNotificationAction(identifier:actionText4, title: actionText4, options: []))
    }

    //Make sure events are handled by this class
    UNUserNotificationCenter.current().delegate = self

    //Set the category for the action. If there are no actions this will remove actions from the category
    let category = UNNotificationCategory(identifier: "defaultcategory", actions: actions, intentIdentifiers: [], options: [])
    UNUserNotificationCenter.current().setNotificationCategories([category])

    //Set the contents of the notification
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    content.sound = UNNotificationSound.default
    content.userInfo = ["payload-simple-notification" : payload]

    //Make sure there is a subtitle before setting it
    if (subtitle != "") {
      content.subtitle = subtitle
    }
    
    content.categoryIdentifier = "defaultcategory"

    //Build the request
    let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

    //Schedule the notification
    UNUserNotificationCenter.current().add(request)

    //Set the result
    pluginResult = CDVPluginResult(status: CDVCommandStatus_OK)

    //Return the result [and specify the callback to make]
    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
  }

  @objc(register:)
  func register(command: CDVInvokedUrlCommand) {
    //Set the result as error in case something fails
    var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)

    //Make sure we have notifications enabled
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (accepted, error) in
      if accepted {
        pluginResult = CDVPluginResult(status: CDVCommandStatus_OK)
        UNUserNotificationCenter.current().delegate = self
      }
    }

    //Return the result [and specify the callback to make]
    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
  }

  @objc(setDelegate:)
  func setDelegate(command: CDVInvokedUrlCommand) {
    //Make sure events are handled by this class
    UNUserNotificationCenter.current().delegate = self
  }

  @objc(remove:)
  func remove(command: CDVInvokedUrlCommand) {
    //Set the result as error in case something fails
    var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)

    let id = command.arguments[0] as? String ?? ""

    //Make sure a valid ID has been passed in
    if (id != "") {
      //Remove any pending notification with the ID
      UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])

      //Remove any active notification with the ID
      UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [id])

      //Set the result
      pluginResult = CDVPluginResult(status: CDVCommandStatus_OK)
    }

    //Return the result [and specify the callback to make]
    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
  }

  //Handles notification clicks
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo as NSDictionary
    var payload = ""

    if (userInfo.count == 1 && userInfo["payload-simple-notification"] != nil) {
      // Handle our own notification payload
      payload = userInfo["payload-simple-notification"] as! String
    } else {
      // If we are not handling our own notification, pass along all userInfo
      // NOTE: We are handling this case so that push notification clicks can also be handled
      do {
        let jsonData = try JSONSerialization.data(withJSONObject: userInfo, options: JSONSerialization.WritingOptions.prettyPrinted)
        payload = String(data: jsonData, encoding: .utf8)!
      } catch {
        // Do nothing if we have a JSON error
      }
    }
    
    commandDelegate.evalJs("cordova.plugins.ios10.simpleNotification.__handler(`\(response.actionIdentifier)`, `\(payload)`)")
    completionHandler()
  }

  //Handles notifications firing in the foreground
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo as NSDictionary

    // If we get a push notification we do not want to handle it here
    if (userInfo["aps"] == nil) {
      // Local notifications show in foreground
      completionHandler( [.alert, .sound, .badge] )
    } else {
      // Push notifications do not show
      completionHandler([])
    }
  }
}
