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

class InGameMenusSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Menu Settings';
		rpcTitle = 'Menu Settings Menu'; //for Discord Rich Presence	

		/*var option:Option = new Option('Freeplay Zoom',
			"If checked, the camera will zoom on beat in Freeplay (not working)",
			'freeplayZoom',
			'bool',
			true);
		option.defaultValue = true;
		addOption(option);*/ // not working, so hide it until it's fixed - FinGonz

		/*
		var option:Option = new Option('Auto Title Skip',
			'If checked, automatically skips the title state.',
			'autotitleskip',
			'bool',
			false);
		option.defaultValue = false;
		addOption(option);
		*/

		super();
	}
}