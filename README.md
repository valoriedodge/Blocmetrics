#BlockMetrics

This is an API tracking and reporting application that lets you track the traffic to your registered web application. All you need to do is create an account [here](http://stark-caverns-21277.herokuapp.com/api/events) and register you site. Then, add this snippet to your site or application:

````
var blocmetrics = {};
  blocmetrics.report = function(eventName) {
   var event = {event: { name: eventName }};
   var request = new XMLHttpRequest();
   request.open("POST", "http://stark-caverns-21277.herokuapp.com/api/events", true);
   request.setRequestHeader('Content-Type', 'application/json');
   request.send(JSON.stringify(event));
 }

 blocmetrics.report("Event Title");
````

You can register multiple URL's from your site, adding this snippet to each appropriate page, or you can also simply change the event name and title in different instances of the snippet in order to track different events within your application.

----
Created by Valorie with BLOC
