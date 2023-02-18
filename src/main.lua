local drawing = require("drawing")
local buttons = require("buttons")

term.setBackgroundColor(colors.black)
term.clear()
term.setCursorBlink(false)

local running = true
local termX, termY = term.getSize()
local modem = peripheral.find("modem") or false
local lines = {
    [1] = "qwertyuiop",
    [2] = "asdfghjkl",
    [3] = "zxcvbnm"
}

drawing:drawStart()
drawing:drawKeyboard(lines)

buttons:createButton(termX, 1, termX, 1, function ()
    drawing:drawStatus("Quiting...")
    running = false
end)

local curX, curY = 3, 13
for idx, line in pairs(lines) do
    local length = line:len()

    for i=1, length do
        local char = line[i]
        if i == length then
            curY = curY + 2
            curX = 4
        else
            curX = curX + 2
        end

        buttons:createButton(curX, curY, curX, curY, function ()
            modem.transmit(233, 234, char)
            drawing:drawStatus("Sending '"..char.."'.")
        end)
    end
    
end

local function modemManager()
    if modem then
        drawing:drawStatus("Connecting.")
    else
        drawing:drawStatus("Waiting for modem.")
        repeat
            local event, side = os.pullEvent("peripheral")
            local periph = peripheral.getType(side)
            if periph == "modem" then
                modem = peripheral.find("modem") or false
            end
        until modem
    end
end

local function click()
    while running do
        local event, button, x, y = os.pullEvent("mouse_click")
        if button == 1 then
            buttons:update(x, y)
        end
    end
end

parallel.waitForAny(modemManager, click)
term.setBackgroundColor(colors.black)
term.setCursorPos(1,1)
term.clear()
os.queueEvent("mx.appQuit")