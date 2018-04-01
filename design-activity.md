Feature | Feedback
---     | ---
What classes does each implementation include? Are the lists the same?  | Room and Block class are like implementation A. Each class only has a constructor and store all attributes in instance variables. Reservation class and Admin class are like implementation B. Each has behaviors.
Write down a sentence to describe each class.  |  Block class are 3-5 number of rooms with a start date and a end date. Room class stores properties of a room. Reservation class stores its property and have two behaviors.  Admin class manage all communications among all classes.
How do the classes relate to each other? It might be helpful to draw a diagram on a whiteboard or piece of paper.  | An Admin has Room, Reservation, and Block. A block has Room s. A reservation has a Room. Admin controls, the other three do not communicate.
What data does each class store? How (if at all) does this differ between the two implementations?  |  Block class are 3-5 number of rooms with a start date and a end date. It also has Room instances and discounted rates. Room class has an id and a rate. Reservation class has a Room instance and a start date and end date. Admin class have Room s, Reservation s and Block s.
What methods does each class have? How (if at all) does this differ between the two implementations?  | It can tell if the reservation date is overlapped with a date range. It also can calculate the cost. It can find a room. reserve a room, create a block and manage the rooms in a block. It's similar to implementation A.
Consider the Order#total_price method. In each implementation:  |
Is logic to compute the price delegated to "lower level" classes like ShoppingCart and CartEntry, or is it retained in Order?  | It should be in Order.
Does total_price directly manipulate the instance variables of other classes?  | Yes.
If we decide items are cheaper if bought in bulk, how would this change the code? Which implementation is easier to modify?  | To modify the price, just change the CartEntry unit price. Same in both implementations.
Which implementation better adheres to the single responsibility principle?  |  Implementation B.
Bonus question once you've read Metz ch. 3: Which implementation is more loosely coupled?  | Implementation A.
