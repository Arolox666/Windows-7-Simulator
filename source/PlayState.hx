package source;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flash.system.System;
import haxe.Json;
import sys.io.File;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxTimer;

// Remove duplicate imports for Sound and SoundChannel

class PlayState extends FlxState {

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

    override public function create() {
        super.create();

        FlxG.mouse.visible = false;

        booting = new haxe.Timer(3000); // 1000ms delay
        booting.run = function() {
            bootingSprite = new FlxSprite();
            bootingSprite.loadGraphic("assets/images/boot.png");
            add(bootingSprite);
        }

        var welcomeTimer = new haxe.Timer(6000); // 1000ms delay
        welcomeTimer.run = function() {
            welcome = new FlxSprite();
            welcome.loadGraphic("assets/images/welcome.png");
            add(welcome);

            FlxG.mouse.visible = true;

            if (booting != null) {
                remove(bootingSprite, true);
            }

            FlxG.sound.play("assets/sounds/startup.wav");
            
            booting.stop();
            welcomeTimer.stop();
        }

        var logon = new haxe.Timer(12000);
        logon.run = function() {
            var explorerOpen = new FlxButton(60, 1040, "Explorer", explo);
            explorerOpen.setGraphicSize(50, 50);
            add(explorerOpen);

            notepadOpen = new FlxButton(117, 1040, "Notepad", notepadO);
            notepadOpen.setGraphicSize(50, 50);
            add(notepadOpen);

            cmdicon = new FlxSprite(174, 1040);
            cmdicon.loadGraphic("assets/images/cmd_icon.png");
            add(cmdicon);

            cmdo = new FlxButton(174, 1040, "Cmd", cmdOpen);
            cmdo.setGraphicSize(50, 50);
            add(cmdo);

            var start = new FlxButton(-8, 1040, "Start", onClick);
            start.setGraphicSize(60, 60);
            add(start);

            var background = new FlxSprite();
            background.loadGraphic("assets/images/background.png");
            add(background);

            var taskbar = new FlxSprite();
            taskbar.loadGraphic("assets/images/taskbar.png");
            add(taskbar);

            FlxG.sound.play("assets/sounds/logon.wav");

            remove(welcome);

            logon.stop();
        }
    }

    function cmdOpen() {
        cmd = new FlxSprite();
        cmd.loadGraphic("assets/images/cmd.png");
        add(cmd);
    }

    function onClick() {
        exitButton = new FlxButton(400, 995, "Shut Down", exitGame);
        exitButton.setGraphicSize(200, 60);
        add(exitButton);
        
        menu = new FlxSprite();
        menu.loadGraphic("assets/images/start-menu2.png");
        add(menu);

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

        var shutdownimage = new FlxSprite();
        shutdownimage.loadGraphic("assets/images/shutdown.png");
        add(shutdownimage);

        var timer = new haxe.Timer(1500); // 1000ms delay
        timer.run = function() {
            System.exit(0);
        }
    } 

    function notepadO() {
        notepadClose = new FlxButton(960, 7, "Close", notepadC);
        notepadClose.setGraphicSize(33, 20);
        notepad = new FlxSprite();
        notepad.loadGraphic("assets/images/notepad.png");
        var jsonString: String = File.getContent("assets/data/notepad.json"); // Replace with your JSON file path
        var jsonObject: Dynamic = Json.parse(jsonString);
        var textFromJson: String = jsonObject.text;

        notepadText = new FlxText(10, 55, FlxG.width - 200, textFromJson); // Create FlxText with text from JSON
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