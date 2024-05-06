package saveload;

import sys.io.File;
import haxe.Json;

class SaveManager {
    public static function save(data:Dynamic, fileName:String):Void {
        var jsonString = haxe.Json.stringify(data);
        File.saveContent(fileName, jsonString);
    }

    public static function load(fileName:String):Dynamic {
        
        var jsonString = File.getContent(fileName);
        var data:Dynamic = haxe.Json.parse(jsonString);
        return data;
    }

    public static function saveUsername(text:String, fileName:String):Void {
        var jsonData:Dynamic = { username: text };
        var jsonString = haxe.Json.stringify(jsonData);
        File.saveContent(fileName, jsonString);
    }

    public static function loadUsername(fileName:String):String {
        var jsonString = File.getContent(fileName);
        var jsonData:Dynamic = haxe.Json.parse(jsonString);
        return jsonData.username;
    }

    public static function savePassword(text:String, fileName:String):Void {
        var jsonData:Dynamic = { password: text };
        var jsonString = haxe.Json.stringify(jsonData);
        File.saveContent(fileName, jsonString);
    }

    public static function loadPassword(fileName:String):String {
        var jsonString = File.getContent(fileName);
        var jsonData:Dynamic = haxe.Json.parse(jsonString);
        return jsonData.password;
    }
}