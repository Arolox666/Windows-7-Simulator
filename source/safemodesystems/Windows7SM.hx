package safemodesystems;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flash.system.System;
import haxe.Json;
import sys.io.File;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import BootingState;

class Windows7SM extends FlxState {

    function addSecurityOptions() {
        securityOptions = new FlxSprite();
        securityOptions.loadGraphic("assets/images/securityOptions.png");
        add(securityOptions);
    }

    function contextmenuclosefunction() {
        if (contextmenuclose != null) {
            remove(contextmenuclose);
            remove(contextmenu);
        }
    }

    var menu: FlxSprite;
    var deleteButton: FlxButton;
    var exitButton: FlxButton;
    var myText: FlxText;
    var closeButton: FlxButton;
    var explorer: FlxSprite;
    var notepad: FlxSprite;
    var notepadText: FlxText;
    var notepadClose: FlxButton;
    var notepadOpen: FlxButton;
    var timer: FlxTimer;
    var sound: openfl.media.Sound; // Specify the full package for Sound
    var channel: openfl.media.SoundChannel; // Specify the full package for SoundChannel
    var biosloading: FlxSprite;
    var bootingSprite: FlxSprite;
    var welcome: FlxSprite;
    var booting: haxe.Timer;
    var securityOptions: FlxSprite; // Define securityOptions at the class level\
    var contextmenu: FlxSprite;
    var contextmenuclose: FlxButton;
    var openclose: haxe.Timer;
    var openmenu: haxe.Timer;
    var bios: FlxSprite;
    var biosclose: FlxSprite;
    var cmdicon: FlxSprite;
    var cmd: FlxSprite;
    var cmdo: FlxButton;
    var cmdText: FlxText;
    var taskbar: FlxSprite;
    var moreShutDownOptionsMenuButton: FlxButton;
    var moreShutDownOptionsMenuSprite: FlxSprite;
    var restartButton: FlxButton;
    var background: FlxSprite;

    override public function create() {
        super.create();

        FlxG.mouse.visible = true;

        var explorerOpen = new FlxButton(60, 1045, "Explorer", explo);
            explorerOpen.setGraphicSize(50, 50);
            add(explorerOpen);

            notepadOpen = new FlxButton(117, 1040, "Notepad", notepadO);
            notepadOpen.setGraphicSize(50, 50);
            add(notepadOpen);

            cmdicon = new FlxSprite(174, 1040);
            cmdicon.loadGraphic("assets/images/cmd_icon.png");
            add(cmdicon);

            cmdo = new FlxButton(174, 1045, "Cmd", cmdOpen);
            cmdo.setGraphicSize(50, 50);
            add(cmdo);

            var start = new FlxButton(-8, 1045, "Start", onClick);
            start.setGraphicSize(60, 60);
            add(start);

            background = new FlxSprite();
            background.loadGraphic("assets/images/safe-mode/background.png");
            add(background);

            taskbar = new FlxSprite();
            taskbar.loadGraphic("assets/images/safe-mode/taskbar.png");
            add(taskbar);

            FlxG.sound.play("assets/sounds/logon.wav");

            remove(welcome);
            notepadO();
    }

    function cmdOpen() {
        cmd = new FlxSprite();
        cmd.loadGraphic("assets/images/cmd.png");
        add(cmd);
        cmdText = new FlxText("C:/Users/%username%/");
        add(cmdText);
    }

    function onClick() {
        exitButton = new FlxButton(260, 1000, "Shut Down", exitGame);
        exitButton.scale.x = 80 / exitButton.width;
        exitButton.scale.y = 36 / exitButton.height;
        add(exitButton);
        moreShutDownOptionsMenuButton = new FlxButton(310, 1000, "More", moreShutDownOptionsMenuFunction);
        moreShutDownOptionsMenuButton.setGraphicSize(10, 36);
        
        menu = new FlxSprite();
        menu.loadGraphic("assets/images/safe-mode/start-menu.png");
        add(menu);
        add(moreShutDownOptionsMenuButton);

        deleteButton = new FlxButton("Close", close);
        deleteButton.screenCenter();
        add(deleteButton);
    }

    function close() {
        if (menu != null) {
            remove(menu, true);
            menu = null;
        }
        if (deleteButton != null) {
            remove(deleteButton, true);
            deleteButton = null;
        }
        if (exitButton != null) {
            remove(exitButton, true);
            exitButton = null;
        }
        if (myText != null) {
            remove(myText); // Remove FlxText
            myText = null;
        }
    }

    function moreShutDownOptionsMenuFunction() {
        restartButton = new FlxButton(360, 1000, "Restart", restartFunction);
        restartButton.setSize(177, 22);
        add(restartButton);
        moreShutDownOptionsMenuSprite = new FlxSprite(360, 943);
        moreShutDownOptionsMenuSprite.loadGraphic("assets/images/safe-mode/logoff-switch-restart.png");
        add(moreShutDownOptionsMenuSprite);
    }

    function restartFunction() {

        remove(menu);
        remove(taskbar);
        remove(background);
        remove(deleteButton);
        notepadC();
        remove(exitButton);
        remove(moreShutDownOptionsMenuButton);
        remove(moreShutDownOptionsMenuSprite);
        remove(restartButton);

        var restarting = new FlxSprite();
        restarting.loadGraphic("assets/images/restarting....png");
        add(restarting);
        var blackScreenTimer = new haxe.Timer(3500);
        blackScreenTimer.run = function() {
            var blackScreen = new FlxSprite();
            blackScreen.loadGraphic("assets/images/blank.png");
            add(blackScreen);
            FlxG.mouse.visible = false;
            blackScreenTimer.stop();
        }
        var restartTimer = new haxe.Timer(7000);
        restartTimer.run = function() {
            FlxG.switchState(new BootingState());
            restartTimer.stop();
        }

    }

    function explo() {
        explorer = new FlxSprite();
        explorer.loadGraphic("assets/images/explorer.png");
        closeButton = new FlxButton(733, 7, "close", explc);
        closeButton.setGraphicSize(33, 20);
        add(closeButton);
        add(explorer);
    }

    function explc() {
        trace("Before removal - explorer: " + explorer);
        trace("Before removal - closeButton: " + closeButton);
    
        if (explorer != null) {
            trace("Removing explorer");
            remove(explorer, true);
            explorer = null;
        }
    
        if (closeButton != null) {
            trace("Removing closeButton");
            remove(closeButton, true);
            closeButton = null; // Corrected variable assignment
        }
    
        trace("After removal - explorer: " + explorer);
        trace("After removal - closeButton: " + closeButton);
    }

    function exitGame() {
        FlxG.sound.play("assets/sounds/shutdown.wav");

        remove(taskbar, true);
        remove(menu, true);
        remove(deleteButton, true);
        remove(exitButton, true);

        var shutdown = new haxe.Timer(1000);
        shutdown.run = function() {
            FlxG.camera.flash(FlxColor.BLACK, 1);
            var shutdownimage = new FlxSprite();
            shutdownimage.loadGraphic("assets/images/shutdown.png");
            add(shutdownimage);
            shutdown.stop();
        }

        var timer = new haxe.Timer(3500); // 1000ms delay
        timer.run = function() {
            System.exit(0);
        }
    } 

    function notepadO() {
        notepadClose = new FlxButton(960, 7, "Close", notepadC);
        notepadClose.setGraphicSize(33, 20);
        notepad = new FlxSprite();
        notepad.loadGraphic("assets/images/notepad.png");

        notepadText = new FlxText(10, 55, FlxG.width - 200, "Nothing to see here right now this will open safe-mode help in future update!!!"); // Create FlxText with text from JSON
        notepadText.setFormat(null, 16, 0x000000, "left");
        add(notepadClose);
        add(notepad);
        add(notepadText);
    }

    function notepadC() {
        if (notepad != null) {
            remove(notepad, true);
            notepad = null;
        }

        if (notepadText != null) {
            remove(notepadText, true);
            notepadText = null;
        }

        if (notepadClose != null) {
            remove(notepadClose, true);
            notepadClose = null;
        }
    }

    override public function update(elapsed: Float) {
        super.update(elapsed);
        // Your update logic goes here if needed
        if (FlxG.keys.justPressed.INSERT) {
            addSecurityOptions();
            trace("Called Successfully");
        }

        if (FlxG.mouse.justPressedRight) {

            if (contextmenu != null) {
                remove(contextmenu);
                remove(contextmenuclose);
            }

            openclose = new haxe.Timer(30);
            openclose.run = function() {
                contextmenuclose = new FlxButton(FlxG.mouse.x + 51, FlxG.mouse.y + 123, "Close", contextmenuclosefunction);
                contextmenuclose.setGraphicSize(184, 32);
                add(contextmenuclose);
            }

            openmenu = new haxe.Timer(25);
            openmenu.run = function() {
                contextmenu = new FlxSprite(FlxG.mouse.x, FlxG.mouse.y);
                contextmenu.loadGraphic("assets/images/contextmenu.png");
                add(contextmenu);
                openclose.stop();
                openmenu.stop();
            }

        }
        
    }
}