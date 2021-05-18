package twinspire.web; #if js

import js.html.HTMLDocument;
import js.Browser;

#if kha
import twinspire.events.Event;
import twinspire.events.EventType;
import twinspire.Animate.*;

import kha.graphics2.Graphics;
import kha.System;
#end

class Website
{

    private var _doc:HTMLDocument;

    public var title(get, set):String;
    public var description(get, set):String;
    public var keywords(get, set):String;


    public function new()
    {
        _doc = Browser.document;

        #if kha
        init();
        #end
    }

    //
    // Private Functions
    //
    var _title:String;
    var _description:String;
    var _keywords:String;

    function get_title()
    {
        return _doc.title;
    }

    function set_title(val)
    {
        return _doc.title = val;
    }

    function get_description()
    {
        // var descEl = _doc.querySelector('meta[name="description"]');
        // if (descEl != null)
        //     return descEl.content;
        // else
        //     return "";

        return _description;
    }

    function set_description(val)
    {
        // var descEl = _doc.querySelector('meta[name="description"]');
        // if (descEl != null)
        //     return descEl.content = val;
        
        // return "";

        return _description = val;
    }

    function get_keywords()
    {
        return _keywords;
    }

    function set_keywords(val)
    {
        return _keywords = val;
    }

    //
    // Start KHA
    //

    #if kha

    // init

    var lastTime:Float;
    var deltaTime:Float;
    var g2:Graphics;

    private function init()
    {
        lastTime = System.time;


        animateInit();
    }

    // events

    var mouseX:Int;
    var mouseY:Int;
    var mouseDown:Bool;
    var mouseReleased:Bool;

    var startTouchX:Int;
    var startTouchY:Int;

    public function handleEvents(e:Event)
    {
        if (e.type == EVENT_MOUSE_MOVE)
        {
            mouseX = e.mouseX;
            mouseY = e.mouseY;
        }
        else if (e.type == EVENT_MOUSE_DOWN)
        {
            mouseDown = true;
        }
        else if (e.type == EVENT_MOUSE_UP)
        {
            mouseDown = false;
            mouseReleased = true;
        }
        else if (e.type == EVENT_TOUCH_START)
        {
            mouseX = e.touchX;
            mouseY = e.touchY;
            startTouchX = e.touchX;
            startTouchY = e.touchY;
            mouseDown = true;
        }
        else if (e.type == EVENT_TOUCH_MOVE)
        {
            mouseDown = false;
            mouseX = e.touchX;
            mouseY = e.touchY;
        }
        else if (e.type == EVENT_TOUCH_END)
        {
            if (mouseDown)
            {
                mouseReleased = true;
                mouseDown = false;
            }

            mouseX = e.touchX;
            mouseY = e.touchY;
        }
    }

    public function begin(g2:Graphics)
    {
        deltaTime = System.time - lastTime;
        animateTime(deltaTime);
        this.g2 = g2;
    }

    public function end()
    {
        mouseReleased = false;
    }

    #end

}
#end