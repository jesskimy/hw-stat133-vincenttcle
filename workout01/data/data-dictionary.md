#Data dictionary 
Here's the description of the data variables:

`team_name` = The team that the player is on.
`game_date` = The date that the game was played.
`season` = The year in which the game was played.
`period` = The period of the game that is being observed. Note that NBA games are divided into 4 periods of 12 minutes. Therefore, `period = 1` refers to the first period (the first 12 minutes of the game).
`minutes_remaining` = The number of minutes remaining in the period at the time of the shot. Note that this number does not take into account the seconds.
`seconds_remaining` = the number of seconds remaining in the period, not taking into account the number of minutes.
`shot_made_flag` = This indicates whether or not a shot was made (y) or missed (n).
`action_type` = This refers to the move executed by the player. These can be used to get past a defender, or to get a clean pass to a teammate.
`shot_type` = This is used to express whether a shot is a two-point or three-point goal.
`shot_distance` = Refers to the distance to the basket (measured in feet).
`opponent` = Refers to the opposing team being played.
`x` and `y` = refer to court coordinates (measured in inches).
`minute` = refers to the minute number where a shot occurred. 
`name` = name of the player