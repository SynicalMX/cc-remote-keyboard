local tKeys = {}
tKeys[32] = 'space'
tKeys[39] = 'apostrophe'
tKeys[44] = 'comma'
tKeys[45] = 'minus'
tKeys[46] = 'period'
tKeys[47] = 'slash'
tKeys[48] = 'zero'
tKeys[49] = 'one'
tKeys[50] = 'two'
tKeys[51] = 'three'
tKeys[52] = 'four'
tKeys[53] = 'five'
tKeys[54] = 'six'
tKeys[55] = 'seven'
tKeys[56] = 'eight'
tKeys[57] = 'nine'
tKeys[59] = 'semicolon'
tKeys[61] = 'equals'
tKeys[65] = 'a'
tKeys[66] = 'b'
tKeys[67] = 'c'
tKeys[68] = 'd'
tKeys[69] = 'e'
tKeys[70] = 'f'
tKeys[71] = 'g'
tKeys[72] = 'h'
tKeys[73] = 'i'
tKeys[74] = 'j'
tKeys[75] = 'k'
tKeys[76] = 'l'
tKeys[77] = 'm'
tKeys[78] = 'n'
tKeys[79] = 'o'
tKeys[80] = 'p'
tKeys[81] = 'q'
tKeys[82] = 'r'
tKeys[83] = 's'
tKeys[84] = 't'
tKeys[85] = 'u'
tKeys[86] = 'v'
tKeys[87] = 'w'
tKeys[88] = 'x'
tKeys[89] = 'y'
tKeys[90] = 'z'
tKeys[91] = 'leftBracket'
tKeys[92] = 'backslash'
tKeys[93] = 'rightBracket'
tKeys[96] = 'grave'
-- tKeys[161] = 'world1'
-- tKeys[162] = 'world2'
tKeys[257] = 'enter'
tKeys[258] = 'tab'
tKeys[259] = 'backspace'
tKeys[260] = 'insert'
tKeys[261] = 'delete'
tKeys[262] = 'right'
tKeys[263] = 'left'
tKeys[264] = 'down'
tKeys[265] = 'up'
tKeys[266] = 'pageUp'
tKeys[267] = 'pageDown'
tKeys[268] = 'home'
tKeys[269] = 'end'
tKeys[280] = 'capsLock'
tKeys[281] = 'scrollLock'
tKeys[282] = 'numLock'
tKeys[283] = 'printScreen'
tKeys[284] = 'pause'
tKeys[290] = 'f1'
tKeys[291] = 'f2'
tKeys[292] = 'f3'
tKeys[293] = 'f4'
tKeys[294] = 'f5'
tKeys[295] = 'f6'
tKeys[296] = 'f7'
tKeys[297] = 'f8'
tKeys[298] = 'f9'
tKeys[299] = 'f10'
tKeys[300] = 'f11'
tKeys[301] = 'f12'
tKeys[302] = 'f13'
tKeys[303] = 'f14'
tKeys[304] = 'f15'
tKeys[305] = 'f16'
tKeys[306] = 'f17'
tKeys[307] = 'f18'
tKeys[308] = 'f19'
tKeys[309] = 'f20'
tKeys[310] = 'f21'
tKeys[311] = 'f22'
tKeys[312] = 'f23'
tKeys[313] = 'f24'
tKeys[314] = 'f25'
tKeys[320] = 'numPad0'
tKeys[321] = 'numPad1'
tKeys[322] = 'numPad2'
tKeys[323] = 'numPad3'
tKeys[324] = 'numPad4'
tKeys[325] = 'numPad5'
tKeys[326] = 'numPad6'
tKeys[327] = 'numPad7'
tKeys[328] = 'numPad8'
tKeys[329] = 'numPad9'
tKeys[330] = 'numPadDecimal'
tKeys[331] = 'numPadDivide'
tKeys[332] = 'numPadMultiply'
tKeys[333] = 'numPadSubtract'
tKeys[334] = 'numPadAdd'
tKeys[335] = 'numPadEnter'
tKeys[336] = 'numPadEqual'
tKeys[340] = 'leftShift'
tKeys[341] = 'leftCtrl'
tKeys[342] = 'leftAlt'
tKeys[343] = 'leftSuper'
tKeys[344] = 'rightShift'
tKeys[345] = 'rightCtrl'
tKeys[346] = 'rightAlt'
-- tKeys[347] = 'rightSuper'
tKeys[348] = 'menu'

local modem = peripheral.find("modem") or false
local termX, termY = term.getSize()

term.setBackgroundColor(colors.gray)
term.clear()
term.setCursorPos(1, 1)
paintutils.drawLine(1, 1, termX, 1, colors.blue)

local str = "Remote Keyboard"
local length = str:len()
local xPos = (math.floor(termX / 2) - math.floor(length / 2))
term.setCursorPos(xPos, 1)
term.setTextColor(colors.white)
term.write(str)

term.setCursorPos(termX, 1)
term.write("X")

local function drawStatus(status)
    term.setBackgroundColor(colors.gray)
    term.setTextColor(colors.lime)
    paintutils.drawLine(1, 2, termX, 2, colors.gray)
    term.setCursorPos(1,2)
    term.write("Status: "..status)
end

if modem then
    drawStatus("Connecting.")
else
    drawStatus("Waiting for modem.")
    repeat
        local event, side = os.pullEvent("peripheral")
        local periph = peripheral.getType(side)
        if periph == "modem" then
            modem = peripheral.find("modem") or false
        end
    until modem
end

modem.open(233)

local function checkExit()
    while true do
        local event, button, x, y = os.pullEvent("mouse_click")
        if x == termX and y == 1 and button == 1 then
            break
        end
    end
end

parallel.waitForAny(function ()
    while true do
        local event, side, channel, replyChannel, message = os.pullEvent("modem_message")
        local key
        for k,v in pairs(tKeys) do
            if v == message then
                key = k
            end
        end
        os.queueEvent("key", key, false)
    end
end, checkExit)
