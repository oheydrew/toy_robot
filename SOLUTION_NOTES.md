Solution Notes
==============

Solution Overview
-----------------

This is my solution to the "Toy Robot" problem, written in Ruby. I decided to write this with Test Driven Development, writing Tests first, and moving into implementation from there. 

I tried to keep a number of principles in mind: 
- Single Object Responsibility
- Sandi Metz [Testing Minimalist](https://youtu.be/URSWYvyc42M?t=1662) testing concepts
- Write Ruby Like Ruby - tried to keep to ruby "passing `:symbols`" syntax etc

#### General design pattern:

The program contains 4 main classes (`Robot`, `Table`, `Game`, and `Parser`),and some supporting classes (Including the `Main Loop`). The `Game` class stores the `Robot`, and `Table`, and uses the `Parser` to route messages between them.

`Robot` is responsible for keeping it's position, and moving itself.

`Table` is responsible for keeping it's size, and reporting if things are or are not in it's boundaries.

`Game` is a controller class. It is responsible for storing the `Robot` and `Table`, and for routing messages between them. It uses the `Parser` to parse commands, and checks if moves or commands are valid before routing the commands through.

`Parser` parses raw strings into commands, and arguments.

#### Things I'm proud of:

I'm quite happy with how things turned out. I'm especially happy with the tidiness of the main `Robot`, `Table` and `Game` functionality itself - Even if using the somewhat "Rails-like" `:symbol` passing was confusing to begin with. I was happy to use the keyword arguments provided by Ruby, and that made passing messages around somewhat more self-descriptive, as well as flexible.

I'm happy with my testing suite, and the TDD methodology I used to get there. I tried to unit test every public method, as well as integration tests for the whole program and private methods. It helped me a number of times during development, and the TDD itself was helpful to figure out where I wanted to go, next.

#### Things I'd do better next time:

I think I overcomplicated things, at some points. At one stage I was generating errors expecting to catch them, before recognising that as a bad method of control flow, and readjusting my path. 

I started off by adding features that the brief did not call for, such as the ability to resize the table, and toward the end it became apparent that whilst perhaps *nice*, these extra features weren't adding much value, and were off brief. The next time, I'll stick more to scope.

The Parser is a little more verbose than I intended, and may be able to be cleaned up with some refactoring, but I wanted to err on "verbose yet readable" rather than "clever but illegible code". I initially ran into a big overcomplication challenge here, deciding initially to generate errors, for handling later- before I recognized that as overcomplicated and possibly even an anti-pattern considering what I wanted to do. I learned a lot about proper exception handling, here.

Class Breakdown
---------------

### **Nouns to consider** (from PROBLEM.md): 
>*ROBOT*, *POSITION*, *TABLE*, *COMMANDS*, *PLACE*, *MOVE*, *TURN*, *FACING*, *LEFT*, *RIGHT*, *REPORT*, *PREVENT*

## Main Classes

### **Game**:
>Main game logic class. Stores the `Robot` and the `Table` instances. Central point for message routing between these classes. `receive_input` takes raw string input and parses it through `Parser`, then routing the returned `:symbols` and `args` to the command methods.
>
>Main `command` methods reside here (`:place`, `:move`, `:turn`, `:report`) and route the desired functionality through to the right places. Errors handled here, too.
>
>`class Game`: Creates an instance of a `Game`.
> - **@table** (*Table.new*)
> - **@robot** (*Robot.new*)
>
>Public methods: `create_table`, `create_robot`, `receive_input` 
>
>Private command methods: `:place`, `:move`, `:turn`, `:report`

### **Robot**: 
>Robot keeps track of it's own `position`, but does not know about the `table` itself. It can `move` itself, `turn` itself, and is able to return it's current `position`, as well as the `next_position` it would move to. 
>
>`class Robot`: Creates an instance of a `Robot`.
> - **@position** (***args*) 
>   - x_pos (*int*)
>   - y_pos (*int*)
>   - facing (*symbol ie :north, :south*)
>
>Public methods: `move`, `next_position`, `turn`

### **Table**: 
>Basically a storage class, that has a method which can determine if cooordinates are `in_bounds?` or not. This can be used for placing and checking valid moves. 
>
>`class Table`: Creates an instance of a `Table`.
> - x (*int - default 5*)
> - y (*int - default 5*)
>
>Public methods: `in_bounds?`

### **Parser**:
>Parses commands from the user input, and returns them back as symbols (to be passed as messages to the `Robot` and `Table`) the main method is `parse`, which is a large case statement which calls other private methods if required (such as for parsing "PLACE").
>
>Returns a `:command`, and optional `args`. Initially had this stripping args from `move` commands, `report` commands, but decided it was not required.
>
>`class Parser` (`class << self`): Class methods only (No instances)
>
>Public methods:
> - `parse`:
>   - *PLACE (x,y,facing)* - Parses PLACE command and return (:parse, args)
>   - *LEFT/RIGHT* - Parse left/right and return (:turn, args)
>   - *MOVE* - Parse move return :move
>   - *REPORT* - Parse report return :report

## Supporting classes

### **Display**:
>Handles output to the user. Prettifies it. 👨‍🎨
>
>`class Display` (`class << self`): Class methods only (No instances)
>
>Public methods: `generic`, `robot`, `error`, `prompt`


### **MainLoop**: 
>This just runs the main program loop. It stores the Game instance, and loops through, asking the player what commands to input.
>
>`class MainLoop`: Class methods only (no instances).
> - **@game** (*Game.new*)
>
>Public methods: `setup`, `run`, `exit`