package saveload;

import sys.io.File;
import haxe.Json;

class SaveManagerUsername {
    public static function saveTextAsJson(text:String, fileName:String):Void {
        var jsonData:Dynamic = { username: text };
        var jsonString = haxe.Json.stringify(jsonData);
        File.saveContent(fileName, jsonString);
    }

    public static function loadJsonAsText(fileName:String):String {
        var jsonString = File.getContent(fileName);
        var jsonData:Dynamic = haxe.Json.parse(jsonString);
        return jsonData.username;
    }
}
