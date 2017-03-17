/*
 * cordova-ios10-local-notification
 * Created By David Briglio - 2016
 * https://github.com/DavidBriglio/cordova-ios10-local-notification
 * Created under the MIT License.
 *
 */

var exec = require("cordova/exec");

var simpleNotification = {
    __handler:function(data){ console.log(data);},

    //Displays the notification
    schedule: function(id, title, body, time, action1, action2, action3) {
        if(id === undefined || id === null || title === undefined || title === null || body === undefined || body === null || action1 === null || action2 === null || action3 === null) {
            return false;
        }
        cordova.exec(null, null, "SimpleNotification", "schedule", [id, title, body, time, action1, action2, action3]);
        return true;
    },

    //Remove any notifications (delivered or pending) with the id matching the paramter
    remove: function(id) {
      if(id === undefined || id === null) {
        return false;
      }
      cordova.exec(null, null, "SimpleNotification", "remove", [id]);
      return true;
    },

    setHandler: function(handler) {
      if( handler !== null) {
        __handler = handler;
      }
    }
};

module.exports = simpleNotification;
