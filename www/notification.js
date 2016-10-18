/*
 * cordova-ios10-local-notification
 * Created By David Briglio - 2016
 * https://github.com/DavidBriglio/cordova-ios10-local-notification
 * Created under the MIT License.
 *
 */

var exec = require("cordova/exec");

var iOS10Notification = {

    //Displays the banner
    schedule: function(title, body, time) {
        if(title === undefined || title === null || body === undefined || body === null) {
            return false;
        }
        cordova.exec(null, null, "iOS10Notification", "schedule", [title, body, time]);
        return true;
    }
};

module.exports = iOS10Notification;
