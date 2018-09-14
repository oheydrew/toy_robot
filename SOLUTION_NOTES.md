Solution Notes
==============

Solution Overview
-----------------

General overview: Trying for O.O principles of single object responsibility. The `robot` and `table` will look after their own internal coordinates, but not know about each other. The `game` will handle passing messages between and the logic of whether things are valid moves. The `command` parser will parse commands, returning symbols for method calls.

TODO: More formal overview of how I tackle this?

Class Breakdown
---------------

### **Nouns to consider** (from PROBLEM.md): 
>*ROBOT*, *POSITION*, *TABLE*, *COMMANDS*, *PLACE*, *MOVE*, *TURN*, *FACING*, *LEFT*, *RIGHT*, *REPORT*, *PREVENT*

### **ToyRobot (Module)**: 
>This will likely just run the main program loop. 

### **Game**:
>Main game logic class. Stores the `Robot` and the `Table` instances. Central point for message routing? // TODO: Update me with more info

### **Robot**: 
>Robot will keep track of it's own `position`, but not know about the `table` itself. It will `move` itself, and be able to return it's current `position` and the `next_position` it plans to `move` to. // TODO: Update this
>
>`class Robot`: Creates an instance of a `Robot`.
> - **@position** (***args*) 
>   - x_pos (*int*)
>   - y_pos (*int*)
>   - facing (*symbol ie :north, :south*)
>
>Public methods: `move`, `next_position`, `turn`

### **Table**: 
>Basically a storage class, that has a method which can determine if cooordinates are `in bounds` or not. This can be used for placing and checking valid moves. // TODO: flesh out @ end
>
>`class Table`: Creates an instance of a `Table`.
> - x (*int - default 5*)
> - y (*int - default 5*)
>
>Public methods: `in_bounds?`

### **Command**:
>Parses commands from the user input, and returns them back as symbols (to be passed as messages to the `Robot` and `Table`) // TODO: Check this over. Pretty much as expected from problem though
>
>`class Command` (`class << self`): Class methods only (No instances)
>
>Public methods:
> - `parse`:
>   - *PLACE (x,y,facing)* - Parses PLACE command and return (:parse, args)
>   - *LEFT/RIGHT* - Parse left/right and return (:turn, args)
>   - *MOVE* - Parse move return :move
>   - *REPORT* - Parse report return :report

### **Display**:
>Handles output to the user. Prettifies it. 👨‍🎨
>
>`class Display` (`class << self`): Class methods only (No instances)
>
>Public methods:
> - `output` (*message*, *style(optional)* //TODO: Maybe not style? Depends on time?)
> - `report` (*position*)
> // TODO: Maybe `intro`? for the introduction
