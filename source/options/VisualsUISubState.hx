package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import ColorblindFilters;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class VisualsUISubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Visuals and UI';
		rpcTitle = 'Visuals & UI Settings Menu'; //for Discord Rich Presence

		var option:Option = new Option('Note Splashes',
			"If unchecked, hitting \"Sick!\" notes won't show particles.",
			'noteSplashes',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Hide HUD',
			'If checked, hides most HUD elements.',
			'hideHud',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option("Showcase Mode",
			'If checked, hides entire HUD and enables botplay :D',
			'showcaseMode',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Hide Watermark',
			'If checked, hides watermark in left-bottom corner while playing song',
			'hideWatermark',
			'bool',
			false);
		addOption(option);

		/*var option:Option = new Option("Mic'd Up HUD",
			'If checked, moves the score text similarly to\nthe Mic\'d up HUD.',
			'micdupHUD',
			'bool',
			false);
		addOption(option);*/

		/*
		var option:Option = new Option('Character Trail',
			'If checked, adds trail behind character like in thorns',
			'characterTrail',				shit lol. i made better finally
			'bool',
			false);
		addOption(option);
		*/

		var option:Option = new Option('Hide Score Text',
			'If checked, hides score, accuracy and misses text under health bar in song',
			'hideScoreText',
			'bool',
			false);
		addOption(option);

		
		var option:Option = new Option('Judgement Counter',
			'Adds a judgement counter \n(REQUIRES SCORE TEXT TO BE VISIBLE)',
			'judgementCounter',
			'bool',
			false);
		addOption(option);

		/* var option:Option = new Option('Score Text Position',
			'Classic is Psych Engine position, New is OS Engine position (never did anything ever)',
			'scoreposition',
			'string',
			'Classic',
			['Classic', 'New']);
		addOption(option); */

		var option:Option = new Option('Colorblind Filter',
			'You can set colorblind filter (makes the game more playable for colorblind people)',
			'colorblindMode',
			'string',
			'None', 
			['None', 'Deuteranopia', 'Protanopia', 'Tritanopia']);
		option.onChange = ColorblindFilters.applyFiltersOnGame;
		addOption(option);
		
		var option:Option = new Option('Time Bar:',
			"What should the Time Bar display?",
			'timeBarType',
			'string',
			'Time Left',
			['Time Left', 'Time Elapsed', 'Song Name', 'OS Time Left', 'OS+ Time Elapsed', 'Song Name + OS+ Time Elapsed', 'Disabled']);
		addOption(option);

		/* var option:Option = new Option('Freeplay Style',
			'What should the freeplay text be like\n D&B Does not have sections',
			'freeplayText',
			'string',
			'Base',
			['Base', 'Center', 'D&B']);
		addOption(option); */

		var option:Option = new Option('Flashing Lights',
			"Uncheck this if you're sensitive to flashing lights!",
			'flashing',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Camera Zooms',
			"If unchecked, the camera won't zoom in on a beat hit.",
			'camZooms',
			'bool',
			true);
		addOption(option);

		/* var option:Option = new Option('Freeplay Zoom',
			"If checked, the camera will zoom on beat in Freeplay (not working)",
			'freeplayZoom',
			'bool',
			true);
		addOption(option); */

		var option:Option = new Option('Score Text Zoom on Hit',
			"If unchecked, disables the Score text zooming\neverytime you hit a note.",
			'scoreZoom',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Health Bar Transparency',
			'How much transparent should the health bar and icons be.',
			'healthBarAlpha',
			'percent',
			1);
		option.scrollSpeed = 1.6;
		option.minValue = 0.0;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		addOption(option);
		
		#if !mobile
		var option:Option = new Option('FPS Counter',
			'If unchecked, hides FPS Counter.',
			'showFPS',
			'bool',
			true);
		addOption(option);
		option.onChange = onChangeFPSCounter;
		#end

		/* var option:Option = new Option('Time Based Main Menu Background',
			'If checked, the background color of the main menu depends on the time of day.',
			'themedmainmenubg',
			'bool',
			false);
		option.defaultValue = false;
		addOption(option); */

		/*
		var option:Option = new Option('Auto Title Skip',
			'If checked, automatically skips the title state.',
			'autotitleskip',
			'bool',
			false);
		option.defaultValue = false;
		addOption(option);
		*/
		
		var option:Option = new Option('Pause Screen Song:',
			"What song do you prefer for the Pause Screen?",
			'pauseMusic',
			'string',
			'Tea Time',
			['None', 'Breakfast', 'Tea Time']);
		addOption(option);
		option.onChange = onChangePauseMusic;
		
		#if CHECK_FOR_UPDATES
		var option:Option = new Option('Check for Updates',
			'On Release builds, turn this on to check for updates when you start the game.',
			'checkForUpdates',
			'bool',
			true);
		addOption(option);
		#end

		super();
	}

	var changedMusic:Bool = false;
	function onChangePauseMusic()
	{
		if(ClientPrefs.pauseMusic == 'None')
			FlxG.sound.music.volume = 0;
		else
			FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.pauseMusic)));

		changedMusic = true;
	}

	override function destroy()
	{
		if(changedMusic) FlxG.sound.playMusic(Paths.music('freakyMenu'));
		super.destroy();
	}

	#if !mobile
	function onChangeFPSCounter()
	{
		if(Main.fpsVar != null)
			Main.fpsVar.visible = ClientPrefs.showFPS;
	}
	#end
}