/*
 * cordova-ios10-local-notification
 * Created By David Briglio
 * https://github.com/DavidBriglio/cordova-ios10-simple-notification
 * Created under the MIT License.
 */
module.exports = {
  // The hidden click handler function
  __handler: function (action, payload) {
    try {
      // Try to decode the payload
      payload = decodeURI(payload);
    } catch (e) {
      // If we cannot decode, we are probably getting a push notification payload
    }

    // Send the data to the registered click handler
    this.__setHandler(action, payload);
  },

  // Click handler function that will be set by the user (this is default)
  __setHandler: function (action, payload) {
    console.log(action, payload);
  },

  // Displays the notification
  schedule: function (
    id,
    title,
    subtitle,
    body,
    time,
    payload,
    action1,
    action2,
    action3,
    action4
  ) {
    if (
      id === null ||
      title === null ||
      body === null ||
      subtitle === null ||
      payload == null ||
      action1 === null ||
      action2 === null ||
      action3 === null ||
      action4 === null
    ) {
      return false;
    }

    //Escape the payload
    payload = encodeURI(payload);

    cordova.exec(null, null, "SimpleNotification", "schedule", [
      id.toString(),
      title,
      subtitle,
      body,
      Number(time),
      payload,
      action1,
      action2,
      action3,
      action4
    ]);
    return true;
  },

  // Register the app to enable notifications
  register: function () {
    cordova.exec(null, null, "SimpleNotification", "register", []);
  },

  // Remove any notifications (delivered or pending) with the id matching the paramter
  remove: function (id) {
    if (id === null) {
      return false;
    }
    cordova.exec(null, null, "SimpleNotification", "remove", [id.toString()]);
    return true;
  },

  // Set the notification delegate to this plugin
  setDelegate: function () {
    cordova.exec(null, null, "SimpleNotification", "setDelegate", []);
  },

  // Sets the handler for notification (body and action) clicks
  setHandler: function (handler) {
    if (handler !== null) {
      this.__setHandler = handler;
      return true;
    }
    return false;
  },

  getNotificationSettings: function () {
    return new Promise(function (resolve, reject) {
      cordova.exec(
        resolve,
        reject,
        "SimpleNotification",
        "getNotificationSettings",
        []
      );
    });
  },

  openNotificationSettings: function () {
    cordova.exec(
      null,
      null,
      "SimpleNotification",
      "openNotificationSettings",
      []
    );
  }
};
