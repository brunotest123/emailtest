Here is the assignment:

Build APIs for a Reservation management iPad/Mobile application for restaurants using Ruby on Rails as backend:

########################### done #########################################

There should be a guest entity in the system with name and email. — guest must always have name and email 

There should be a restaurant entity in the system with name, email and phone. — restaurant must always have name, phone and email.

There will be tables in restaurants with table name, minimum and maximum number of guests that can sit on them.

Restaurants operate in shifts for example - Morning shift - 9 am to 1 pm, Evening shift - 6pm to 11 pm — Shift end time can’t be less than the start time

The table for reservation, the restaurant shift in which you want the reservation, reservation time -- reservation time must lie within restaurant shift start time and end time, guest who made the reservation , guest count for the reservation -- the guest count must be between maximum and minimum capacity of the table selected for reservation -

The API shouldn’t accept invalid phone or email formats

Create an API endpoint that creates a reservation for the guest in a restaurant. The API should accept -

**Create an API end point that returns a list of reservations for a restaurant. Reservation should have these fields - Reservation time, guest count, guest name, table name **>b class="">**

When the reservation is created the guest should receive an email with reservation details.

When the reservation is created the restaurant should receive an email with guest details.

########################### done #########################################


Create an API endpoint that updates the reservation - when the reservation details are changed, the guest should receive an email with - old and updated reservation time, old and updated guest count.


Notes:

1. Write test cases.

2. APIs should have good performance.

3. Submit the code in GitHub public repository and share the link

4. Deploy the app on Heroku Average time .5 day**

Please email me back the results once you're done. It would be great if you could find time to do it as soon as possible. After this, we will follow up with a technical Skype call with our former Lead Backend Engineer.

Thanks and all the best!

If you have any question along the way, please do not hesitate to reach out to me.