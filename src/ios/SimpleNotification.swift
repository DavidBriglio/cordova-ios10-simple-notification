@objc(SimpleNotification) class SimpleNotification : CDVPlugin {
  @objc(schedule:)
  func schedule(command: CDVInvokedUrlCommand) {

    //Set the result as error in case something fails
    var pluginResult = CDVPluginResult(
      status: CDVCommandStatus_ERROR
    )

    let title = command.arguments[0] as? String ?? ""
    let body = command.arguments[1] as? String ?? ""
    //Get time
    //Get actions

    //Set the result
    pluginResult = CDVPluginResult(
      status: CDVCommandStatus_OK,
      messageAs: title
    )

    //Return the result [and specify the callback to make]
    self.commandDelegate!.send(pluginResult, callbackId: command.callbackId)
  }
}
