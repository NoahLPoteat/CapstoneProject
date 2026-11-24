class_name AudioHandler extends Node

var SE_SET_VOLUME: float = 1.0 ## 0.0 - 1.0 
var MUSIC_SET_VOLUME: float = 1.0 ## 0.0 - 1.0

##preloaded common sound effects, such as striking and other things
enum COMMON_SOUNDS {
	
}

#enum sounds to the actual sound file (we should preload all of them


func adjust_se_volume(to_vol: float):
	if to_vol >= 1.0:
		SE_SET_VOLUME = 1.0
	elif to_vol <= 0.0:
		SE_SET_VOLUME = 0.0
	else:
		SE_SET_VOLUME = to_vol

func adjust_music_volume(to_vol: float):
	if to_vol >= 1.0:
		MUSIC_SET_VOLUME = 1.0
	elif to_vol <= 0.0:
		MUSIC_SET_VOLUME = 0.0
	else:
		MUSIC_SET_VOLUME = to_vol

##Adjust to allow playing from sound file so we can pre load
## load file from path
## check for free audio_stream
## find first free or last used if none free
##	play audio in found stream
func play_sound_effect(to_play_enum: COMMON_SOUNDS, file_path: String = "", from_file: bool = false):
	pass

##TODO:
##	Open new audio channel
##	set new volume from 0 to MUSIC_SET_VOLUME
##	set cur volume from MUSIC_SET_VOLUME to 0
##	cur = new 
func start_new_song():
	pass

##TODO:
##pause da msuic
func pause_music():
	pass

##TODO:
##unpause da music
func continue_music():
	pass
