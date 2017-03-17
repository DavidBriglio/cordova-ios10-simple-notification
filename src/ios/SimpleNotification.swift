import UserNotifications

@objc(SimpleNotification) class SimpleNotification : CDVPlugin {
  @objc(schedule:)
  func schedule(command: CDVInvokedUrlCommand) {

    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (accepted, error) in
      if !accepted {
        print("Notification access not accepted.")
      }
    }

    //Set the result as error in case something fails
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    let id = command.arguments[0] as? String ?? ""
    let title = command.arguments[1] as? String ?? ""
    // let subtitle = command.arguments[2] as? String ?? ""
    let body = command.arguments[2] as? String ?? ""
    let timetrigger = command.arguments[3] as? Double ?? 0.0
    let action1 = command.arguments[4] as? String ?? ""
    let action2 = command.arguments[5] as? String ?? ""
    let action3 = command.arguments[6] as? String ?? ""

    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timetrigger, repeats: false)

    let content = UNMutableNotificationContent()
    content.title = title
    content.body = body
    // content.sound = UNNotificationSound.default()
    let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)

    // UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    UNUserNotificationCenter.current().add(request) { (error) in
      if let error = error {
        print("Error: \(error)")
      }
    }

    //Set the result
    pluginResult = CDVPluginResult(
      status: CDVCommandStatus_OK,
      messageAs: title
    )

    //Return the result [and specify the callback to make]
    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
  }
  @objc(remove:)
  func remove(command: CDVInvokedUrlCommand) {
    //Set the result as error in case something fails
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    let id = command.arguments[0] as? String ?? ""

    //Remove any pending notification with the ID
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])

    //Remove any active notification with the ID
    UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [id])

    //Set the result
    pluginResult = CDVPluginResult(
      status: CDVCommandStatus_OK,
      messageAs: "error"
    )

    //Return the result [and specify the callback to make]
    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
  }
}
