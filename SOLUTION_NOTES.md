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

### **MainLoop**: 
>This just runs the main program loop. It stores the Game instance, and loops through, asking the player what commands to input.
>
>`class MainLoop`: Class methods only (no instances).
> - **@@game** (*Game.new*)
>
>Public methods: `start`

### **Game**:
>Main game logic class. Stores the `Robot` and the `Table` instances. Central point for message routing between these classes.
>Main `command` methods reside here (`:place`, `:move`, `:turn`, `:report`) and route the desired functionality through to the right places. Errors handled here, too.
>
>`class Game`: Creates an instance of a `Game`.
> - **@table** (*Table.new*)
> - **@robot** (*Robot.new*)
>
>Public methods: `create_table`, `create_robot`, `receive_input` 
>Private methods: `:place`, `:move`, `:turn`, `:report`, `valid_move?` // TODO: Move valid_move to private

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

### **Parser**:
>Parses commands from the user input, and returns them back as symbols (to be passed as messages to the `Robot` and `Table`) // TODO: Check this over. Pretty much as expected from problem though
>
>`class Parser` (`class << self`): Class methods only (No instances)
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
