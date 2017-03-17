/*
 * cordova-ios10-local-notification
 * Created By David Briglio - 2016
 * https://github.com/DavidBriglio/cordova-ios10-local-notification
 * Created under the MIT License.
 *
 */

var exec = require("cordova/exec");

var simpleNotification = {

    //The hidden click handler function
    __handler:function(data){ console.log(data);},

    //Displays the notification
    schedule: function(id, title, subtitle, body, time, action1, action2, action3, action4) {
        if(id === null || title === null || body === null || subtitle === null || action1 === null ||
          action2 === null || action3 === null || action4 === null) {
            return false;
        }
        cordova.exec(null, null, "SimpleNotification", "schedule", [id, title, subtitle, body, time, action1, action2, action3, action4]);
        return true;
    },

    //Register the app to enable notifications
    register: function() {
      cordova.exec(null, null, "SimpleNotification", "register", []);
    },

    //Remove any notifications (delivered or pending) with the id matching the paramter
    remove: function(id) {
      if(id === null) {
        return false;
      }
      cordova.exec(null, null, "SimpleNotification", "remove", [id]);
      return true;
    },

    //Sets the handler for notification (body and action) clicks
    setHandler: function(handler) {
      if( handler !== null) {
        this.__handler = handler;
        return true;
      }
      return false;
    }
};

module.exports = simpleNotification;
