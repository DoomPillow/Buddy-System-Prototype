extends Node

# Player stuff
var playerpos_1 = Vector2();
var playerpos_2 = Vector2();

var CroakkumSalad = false;

# Room logic
var currentlevel : int = -1; # 0 by default
var treasure_got := false;

# Cursor logic
var cursortimer = 210;

# Nuke ending
var traps_set_off = 0;
var nuke_unlocked = false;
var code_array = [0,0,0,0,0,0];

# Status of whether the bomb was detonated or not
# 0 = neutral
# 1 = detonated
# -1 = diffused
var DETONATE_STATUS = 0;
