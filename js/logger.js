// Write a simple lambda function that logs the event to the console.

exports.handler = (event, context, callback) => {
    console.log(event);
    callback(null, event);
    // Print the current time
    console.log("Current time is: " + new Date());
};
