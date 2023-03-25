// Write a simple lambda function that logs the event to the console.
const { CloudWatchClient, PutMetricDataCommand } = require("@aws-sdk/client-cloudwatch");

exports.handler = async (event, context, callback) => {
    try{
        console.log(event);
        callback(null, event);
        // Print the current time
        var timestamp = new Date();
        console.log("Current time is: " + timestamp);

        // Write to a custom Cloudwatch metric
        console.log("Reporting to Cloudwatch");
        

        
        const cloudwatch = new CloudWatchClient({});


        // Create the parameters for the metric
        // Define the custom metric namespace and name
        const namespace = 'CloudWatchClassSampleNamespace';
        const metricName = 'CloudWatchClassSampleMetric';
        const metricData = {
            MetricData: [
            {
                MetricName: metricName,
                Dimensions: [
                {
                    Name: 'SampleDimension',
                    Value: 'SampleDimensionValue'
                },
                ],
                Timestamp: timestamp,
                Unit: 'Count',
                Value: 1
            },
            ],
            Namespace: namespace
        };
     
        const data = await cloudwatch.send(new PutMetricDataCommand(metricData));
        console.log("Success:", JSON.stringify(data));
    } catch (err) {
        console.log("Error:", err);
        throw err;
    }
};

//exports.handler({}, {}, (err, data) => {});