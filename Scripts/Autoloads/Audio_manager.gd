extends Node

var _master_bus : int
var _music_bus : int
var _sfx_bus : int

var master_volume : float = 1.0
var music_volume : float = 1.0
var sfx_volume : float = 1.0
var is_3d : bool = false
@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var music_player_3d: AudioStreamPlayer = $MusicPlayer3d

func _ready() -> void:
	_master_bus = AudioServer.get_bus_index("Master")
	_music_bus  = AudioServer.get_bus_index("Music")
	_sfx_bus    = AudioServer.get_bus_index("Sfx")
	music_player.play() 

func set_master_volume(value: float) -> void:
	master_volume = value
	AudioServer.set_bus_volume_db(_master_bus, linear_to_db(value))

func set_music_volume(value: float) -> void:
	music_volume = value
	AudioServer.set_bus_volume_db(_music_bus, linear_to_db(value))

func set_sfx_volume(value: float) -> void:
	sfx_volume = value
	AudioServer.set_bus_volume_db(_sfx_bus, linear_to_db(value))

func get_master_volume() -> float:
	return master_volume

func get_music_volume() -> float:
	return music_volume

func get_sfx_volume() -> float:
	return sfx_volume
	
func play_music(stream: AudioStream) -> void:
	music_player.stream = stream
	music_player.play()
	
func play_music_3d(stream: AudioStream) -> void:
	music_player_3d.stream = stream
	music_player_3d.play()
	
func stop_music() -> void:
	music_player.stop()
	music_player_3d.stop()
	
func switch_to_3d() -> void:
	if is_3d:
		return
	is_3d = true
	stop_music()
	music_player_3d.play()

func switch_to_2d() -> void:
	if not is_3d:
		return
	is_3d = false
	stop_music()
	music_player.play()
