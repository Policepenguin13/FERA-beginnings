extends Node2D

# input event actions: UP DOWN LEFT RIGHT
# ^ possible notes/things

# sequence = an array of all the notes in order for this tune/minigame/thing,
# simple eg:
#["LEFT","DOWN","LEFT", "UP","RIGHT","UP", "DOWN","LEFT","DOWN", "RIGHT","UP","RIGHT"] 
# the sequence is 12 steps long

# "step" = where we're up to in the sequence numerically
# "note" = sequence[step], 
# if the player inputs an event action that isn't note, restart,
# if they input correctly (eg press "LEFT" when next=="LEFT"), step+=1
# careful to give a bit of time, like maybe you have 0.5 second cooldown
# between the correct input pressed/released and when it goes to next step
