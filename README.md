### Description
A command line version of chess.
### Some Concepts
<ol>
  <li>Object Orientated Programming</li>
  <li>Composition</li>
  <li>Single Responsibility</li>
  <li>Using interfaces</li>
  <li>Test Driven Development</li>

</ol>

#### Running the game
You can also view the game here on [Replit](https://replit.com/@linkonsat/chess-4#.replit). Please note that you cannot install gems such as msgpack in replit. You can play a game, but will not be able to save it. Therefore it is highly recommended to simply clone the repository and install the appropriate gems to enable all features. Make sure to uncomment out msgpack in game.rb!

### Prequisites 
Make sure you have the Ruby gem downloaded. Here is a good [guide](https://linuxize.com/post/how-to-install-ruby-on-ubuntu-20-04/)
Make sure you have the RSpec gem downloaded as well. Which is as easy as 

~~~bash
gem install rspec
~~~

Next, make sure you have git installed. You can find the guide [here](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
## Using Command Line
2. Clone the repository by running `git clone git@github.com:linkonsat/chess.git`
3. cd into the appropriate directory that contains the chess game.

~~~bash
cd <The directory here>
~~~

5. Ensure your on the directory location containing main_game.rb 
6. enter ruby main_game.rb in the console 

### Lessons Learned
1. Scaling an application using a Test Driven Development to ensure methods aren't breaking upon scaling up.
2. Used an Object Oriented Programming style to create objects to represent separate concerns and build interacting objects with a user facing object.
3. How to apply data structures such as a doubly linked list to handle data to enable different ways to manipulate the game state.
4. How to use git branches to create feature branches to keep the main branch in a consistently working stable state.
