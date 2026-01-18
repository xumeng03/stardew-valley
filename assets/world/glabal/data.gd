extends Node

# input actions
const ACTIONS_LEFT := "left"
const ACTIONS_RIGHT := "right"
const ACTIONS_UP := "up"
const ACTIONS_DOWN := "down"
const ACTIONS_ACTION := "action"
const ACTIONS_BEHAVIOR_SWITCH_PREVIOUS := "behavior_swtich_previous"
const ACTIONS_BEHAVIOR_SWITCH_NEXT := "behavior_swtich_next"
const ACTIONS_NEXT_DAY := "next_day"
const ACTIONS_SEED_SWITCH_NEXT := "seed_swtich_next"
const ACTIONS = [ACTIONS_LEFT, ACTIONS_RIGHT, ACTIONS_UP, ACTIONS_DOWN, ACTIONS_ACTION, ACTIONS_BEHAVIOR_SWITCH_PREVIOUS, ACTIONS_BEHAVIOR_SWITCH_NEXT, ACTIONS_NEXT_DAY, ACTIONS_SEED_SWITCH_NEXT]

# animation names
const ANIMATION_AXE := "axe"
const ANIMATION_HOE := "hoe"
const ANIMATION_SWORD := "sword"
const ANIMATION_WATER := "water"
const ANIMATION_FISH := "fish"
const ANIMATION_SEED := "seed"
const ANIMATIONS = [ANIMATION_AXE, ANIMATION_HOE, ANIMATION_SWORD, ANIMATION_WATER, ANIMATION_FISH, ANIMATION_SEED]


# tool textures
const TEXTURE_AXE := preload("res://assets/tools/axe.png")
const TEXTURE_HOE := preload("res://assets/tools/hoe.png")
const TEXTURE_SWORD := preload("res://assets/tools/sword.png")
const TEXTURE_WATER := preload("res://assets/tools/water.png")
const TEXTURE_FISH := preload("res://assets/tools/fish.png")
const TEXTURE_SEED := preload("res://assets/tools/seed.png")
const TEXTURES = [TEXTURE_AXE, TEXTURE_HOE, TEXTURE_SWORD, TEXTURE_WATER, TEXTURE_FISH, TEXTURE_SEED]

# seed textures
const TEXTURE_CRON := preload("res://assets/seeds/corn.png")
const TEXTURE_PUMPKIN := preload("res://assets/seeds/pumpkin.png")
const TEXTURE_TOMATO := preload("res://assets/seeds/tomato.png")
const TEXTURE_WHEAT := preload("res://assets/seeds/wheat.png")
const SEED_TEXTURES = [TEXTURE_CRON, TEXTURE_PUMPKIN, TEXTURE_TOMATO, TEXTURE_WHEAT]

# tile
const TILE_SIZE := 16

# weather
var weather: bool = false