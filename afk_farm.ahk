#NoEnv  
;#Warn  
SendMode Input  
;#SingleInstance, Force 
SetWorkingDir %A_ScriptDir%  
active := false
currentAction := "Idle"

; variables
global currentAction, hasClanBoost, lbPixel_xCord, lbPixel_yCord, lbHexCode, tp_xCord, tp_yCord, scroll_xCord, scroll_yCord, rbRoad_xCord, rbRoad_yCord
hasClanBoost := true
lbPixel_xCord := 1715
lbPixel_yCord := 81
lbHexCode := 0x1D1B19 
tp_xCord := 176
tp_yCord := 398
scroll_xCord := 1490
scroll_yCord := 321
rbRoad_xCord := 763
rbRoad_yCord := 744

; GUI
Gui, +AlwaysOnTop
Gui, Color, FFFFFF 
Gui, Font, s14
Gui, Add, Tab2, w370 h200, Status||Config
Gui, Add, Text, x25 y50, F1 to activate
Gui, Add, Text, x25 y80, F2 to deactivate
Gui, Add, Text, x25 y110, Script Enabled:
Gui, Add, Text, x160 y110 w100 h30 left vWorkerText, % active
Gui, Add, Text, x25 y140, Current Action: 
Gui, Add, Text, x160 y140 w150 h60 left vActionText, % currentAction 

; tab 2
Gui, Tab, 2
Gui, Add, Button, gConfig w330, Click to enter configuration mode
Gui, Show, x10 y10 w400 h220, Collector's PS99 Anti-Kick, RunOnGuiShow

ImportConfig()

RunOnGuiShow:
return

ImportConfig()

Config:
    transparent_img := A_ScriptDir "\Images\transparent_help.png"
    lb_pixel_help_img := A_ScriptDir "\Images\lb_pixel_help.png"
    tp_icon_help_img := A_ScriptDir "\Images\tp_icon_help.png"
    scroll_bar_help_img := A_ScriptDir "\Images\scroll_bar_help.png"
    rb_road_help_img := A_ScriptDir "\Images\rainbow_road_icon_help.png"

    ; Check transparentness
    SplashImage, %transparent_img%, m2 fm20 c0, ,After you close this tip card: Go into roblox settings and change "background transparency" to maximum `n`n Right click anywhere to see the next step after this tip card is closed, Tip Card
    WaitForTipCardClose()
    
    Loop
    {
        Sleep, 50
        if (GetKeyState("RButton", "P")) ; Check if the right mouse button is pressed
        {
            break
        }    
    }

    ; Get leaderboard pixel coordinates
    SplashImage, %lb_pixel_help_img%, m2 fm20 c0, ,After you close this tip card: right click on one of the pixels at the top of the leaderboard capture the coordinates of it `n`n The image below shows the acceptable area you can capture, Tip Card
    WaitForTipCardClose()

    Loop
    {
        Sleep, 50
        if (GetKeyState("RButton", "P")) ; Check if the right mouse button is pressed
        {
            break
        }    
    }

    WinActivate, Roblox
    Sleep, 100
    MouseGetPos, MouseX, MouseY
    lbPixel_xCord := MouseX
    lbPixel_yCord := MouseY
    Click, Right, , U

    ; Get tp icon coordinates
    SplashImage, %tp_icon_help_img%, m2 fm20 c0, ,After you close this tip card: right click on the center of the teleport icon to capture the coordinates of it, Tip Card
    
    WaitForTipCardClose()

    Loop
    {
        Sleep, 50
        if (GetKeyState("RButton", "P")) ; Check if the right mouse button is pressed
        {
            break
        }    
    }

    WinActivate, Roblox
    Sleep, 100
    MouseGetPos, MouseX, MouseY
    tp_xCord := MouseX
    tp_yCord := MouseY
    Click, Right, , U
    
    ; Get scroll bar coordinates
    SplashImage, %scroll_bar_help_img%, m2 fm20 c0, ,After you close this tip card: right click on the center of the scroll bar icon to capture the coordinates of it `n`n It is the fat black part shown in the image below, Tip Card
    
    WaitForTipCardClose()

    Loop
    {
        Sleep, 50
        if (GetKeyState("RButton", "P")) ; Check if the right mouse button is pressed
        {
            break
        }    
    }

    WinActivate, Roblox
    Sleep, 100
    MouseGetPos, MouseX, MouseY
    scroll_xCord := MouseX
    scroll_yCord := MouseY
    Click, Right, , U

    ; Get rainbow road icon coordinates
    SplashImage, %rb_road_help_img%, m2 fm20 c0, ,After you close this tip card: right click on the center of the rainbow road icon to capture the coordinates of it `n`n Make sure you scroll right to the bottom of the map before capturing, Tip Card
    
    WaitForTipCardClose()

    Loop
    {
        Sleep, 50
        if (GetKeyState("RButton", "P")) ; Check if the right mouse button is pressed
        {
            break
        }    
    }

    WinActivate, Roblox
    Sleep, 100
    MouseGetPos, MouseX, MouseY
    rbRoad_xCord := MouseX
    rbRoad_yCord := MouseY
    Click, Right, , U

    MsgBox, 4, Confirmation, Do you have clan boost? ; 4 is the value for Yes/No buttons

    ; Check the result of the MsgBox
    IfMsgBox Yes
    {
        hasClanBoost := true
    }
    else
    {
        hasClanBoost := false
    }

    ; Saves coordinates to file
    SaveToConfig()

    return

WaitForTipCardClose()
{
    while (WinExist("Tip Card"))
    {
        if (WinExist("Tip Card") = 0)
        {
            break
        }

        Sleep, 100
    }

    return
}

SaveToConfig()
{
    IniWrite, %hasClanBoost%, config.ini, hasClanBoost, hasClanBoost
    IniWrite, %lbPixel_xCord%, config.ini, lbPixelXCord, lbPixel_xCord
    IniWrite, %lbPixel_yCord%, config.ini, lbPixelYCord, lbPixel_yCord
    IniWrite, %tp_xCord%, config.ini, tpXCord, tp_xCord
    IniWrite, %tp_yCord%, config.ini, tpYCord, tp_yCord
    IniWrite, %scroll_xCord%, config.ini, scrollXCord, scroll_xCord
    IniWrite, %scroll_yCord%, config.ini, scrollYCord, scroll_yCord
    IniWrite, %rbRoad_xCord%, config.ini, rbRoadXCord, rbRoad_xCord
    IniWrite, %rbRoad_yCord%, config.ini, rbRoadYCord, rbRoad_yCord
    MsgBox, Settings saved to config.ini
}

ImportConfig()
{
    configPath := A_ScriptDir "\config.ini"
    if FileExist(configPath)
    {
        IniWrite, hasClanBoost, config.ini, hasClanBoost, hasClanBoost
        IniWrite, lbPixel_xCord, config.ini, lbPixelXCord, lbPixel_xCord
        IniWrite, lbPixel_yCord, config.ini, lbPixelYCord, lbPixel_yCord
        IniWrite, tp_xCord, config.ini, tpXCord, tp_xCord
        IniWrite, tp_yCord, config.ini, tpYCord, tp_yCord
        IniWrite, scroll_xCord, config.ini, scrollXCord, scroll_xCord
        IniWrite, scroll_yCord, config.ini, scrollYCord, scroll_yCord
        IniWrite, rbRoad_xCord, config.ini, rbRoadXCord, rbRoad_xCord
        IniWrite, rbRoad_yCord, config.ini, rbRoadYCord, rbRoad_yCord
    }
    else
    {
        settings_help_img := A_ScriptDir "\Images\settings_help.png"
        SplashImage, %settings_help_img%, m2 fm20 c0, ,Detected first time use - make sure to go to settings to start configuration `n`n If it is not first time use - your config file is ether missing or corrupted, , Tip Card
    }

    return
}

; starts main loop
F1::
    WinActivate, Roblox
    Sleep, 200

    active := true

    while (active = true)
    {   
        GuiControl,, ActionText, Checking for disconnection
        
        ; Click center of the screen
        MouseMove, A_ScreenWidth * 0.5, A_ScreenHeight * 0.5
        Click 

        ; Check if you disconnected from the server 
        ImageSearch, FoundX, FoundY, A_ScreenWidth * 0.25, A_ScreenHeight * 0.25, A_ScreenWidth * 0.5, A_ScreenHeight * 0.5, *10 *Trans10 %A_ScriptDir%\Images\disconnect.png

        if (ErrorLevel = 0)
        {
            GuiControl,, ActionText, Detected disconnection
            Rejoin()
        }

        ; Check if instance of roblox is open
        Process, Exist, RobloxPlayerBeta.exe

        if (ErrorLevel = 0)
        {
            GuiControl,, ActionText, Detected disconnection, rejoining
            Rejoin()
        }

        Sleep, 5000
    }

    return

; restarts script
F2::
    Click, up
    Reload
    return

; tests rejoin code
F3::
    Rejoin()   
    return 

; tests walking to rb road from spawn code
F4::
    WalkToRainbowRoad()
    return

; get cords of mouse pos
F6:: 
    WinActivate, Roblox
    Sleep, 200
    MouseGetPos, MouseX, MouseY
    SplashImage, , m2 fm20, ,%MouseX% %MouseY%, Tip Card
    return

Rejoin()
{
    Run % "roblox://placeID=8737899170"
    Sleep, 10000  
    attempts := 0
    GuiControl,, ActionText, Loading in
    Sleep, 20000

    loaded := false
    
    while (loaded = false)
    {
        PixelSearch, OutX, OutY, lbPixel_xCord, lbPixel_yCord, lbPixel_xCord, lbPixel_yCord, %lbHexCode%     
    
        ; Checks leaderboard pixel in top right 
        if (ErrorLevel = 0)
        {
            GuiControl,, ActionText, Loaded in
            attempts := 0
            loaded := true
            Sleep, 5000
        }
        else if (ErrorLevel = 1)
        {
            if (attempts > 30)
            {
                Run % "roblox://placeID=8737899170"
                attempts := 0
                Sleep, 10000
            }
            else
            {
                attempts++
                Sleep, 5000
            }
        }
        else if (ErrorLevel = 2)
        {
            MsgBox, Failed to begin search for pixel
        }
    }

    WalkToRainbowRoad()

    return
}

WalkToRainbowRoad()
{
    GuiControl,, ActionText, Looking for Rainbow Road on map

    if (hasClanBoost = true)
    {
        multiplier := 1
    }
    else 
    {
        multiplier := 1.2
    }

    ; Open map
    MouseMove, tp_xCord, tp_yCord
    Sleep, 100 
    MouseMove, tp_xCord + 2, tp_yCord
    Sleep, 100
    Click
    Sleep, 1000

    ; scroll to rb road
    MouseMove, scroll_xCord, scroll_yCord
    Sleep, 10
    MouseMove, scroll_xCord, scroll_yCord + 2
    Sleep, 10
    Click, down
    Sleep, 10
    MouseMove, scroll_xCord, A_ScreenHeight * 0.9
    Sleep, 500
    Click, up

    ; click on rb road
    MouseMove, rbRoad_xCord, rbRoad_yCord
    Sleep, 10
    MouseMove, rbRoad_xCord + 2, rbRoad_yCord
    Sleep, 10
    Click

    ; Walk to area 
    GuiControl,, ActionText, Walking to middle
    Sleep, 8000
    Send, {d Down}
    Sleep, multiplier * 2790
    Send, {d Up}

    ; Angle camera
    MouseMove, A_ScreenWidth * 0.5, A_ScreenHeight * 0.5
    Sleep, 100
    Click, right down
    Sleep, 100
    MouseMove, A_ScreenWidth * 0.5, A_ScreenHeight * 0.6
    Sleep, 100

    Loop, 6
    {
        Click, WheelDown
        Sleep, 500
    }

    Click, right up

    return
}