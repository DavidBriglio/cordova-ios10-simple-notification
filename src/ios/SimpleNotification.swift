import UserNotifications

@objc(SimpleNotification) class SimpleNotification : CDVPlugin {
  @objc(schedule:)
  func schedule(command: CDVInvokedUrlCommand) {

    //Make sure we have notifications enabled
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (accepted, error) in
      if !accepted {
        print("Error: \(error)")
      }
    }

    //Set the result as error in case something fails
    var pluginResult = CDVPluginResult(status: CDVCommandStatus_ERROR)

    //Get all information for the notification
    let id = command.arguments[0] as? String ?? ""
    let title = command.arguments[1] as? String ?? ""
    let subtitle = command.arguments[2] as? String ?? ""
    let body = command.arguments[3] as? String ?? ""
    let timetrigger = command.arguments[4] as? Double ?? 5.0
    let actionText1 = command.arguments[5] as? String ?? ""
    let actionText2 = command.arguments[6] as? String ?? ""
    let actionText3 = command.arguments[7] as? String ?? ""
    let actionText4 = command.arguments[8] as? String ?? ""

    //Set the trigger time according to what the input was
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timetrigger, repeats: false)

    //Set the notification actions
    var actions = [UNNotificationAction]()

    if( actionText1 != "" ) {
      actions.append(UNNotificationAction(identifier: actionText1, title: actionText1, options: []))
    }

    if( actionText2 != "" ) {
      actions.append(UNNotificationAction(identifier:actionText2, title: actionText2, options: []))
    }

    if( actionText3 != "" ) {
      actions.append(UNNotificationAction(identifier:actionText3, title: actionText3, options: []))
    }

    if( actionText4 != "" ) {
      actions.append(UNNotificationAction(identifier:actionText4, title: actionText4, options: []))
    }

    //Set the category for the action. If there are no actions this will remove actions from the category
    let category = UNNotificationCategory(identifier: "defaultcategory", actions: actions, intentIdentifiers: [], options: [])
    UNUserNotificationCenter.current().setNotificationCategories([category])

    //Set the contents of the notification
    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    content.subtitle = subtitle
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
}
