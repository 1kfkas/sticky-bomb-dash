extends Node

@onready var menuScene = preload("res://Levels/Menu.tscn")
@onready var gameScene = preload("res://Levels/Game.tscn")

@export var score: int = 0

@export var player: CharacterBody2D
@export var camera: Camera2D
@export var shake: float
