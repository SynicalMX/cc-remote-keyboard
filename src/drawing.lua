local termX, termY = term.getSize()
local drawing = {}

function drawing:drawKeyboard(lines)
    term.setBackgroundColor(colors.gray)
    local offset = 0
    for idx, line in ipairs(lines) do
        local output = ""
        for i=1, string.len(line) do
            output = output.." "..string.sub(line, i, i)
        end
        term.setCursorPos(drawing:getCenter(output), (termY-(termY / 3)) + offset)
        term.write(output)
        offset = offset + 2
    end
end

function drawing:getCenter(str)
    local length = string.len(str)
    return (math.floor(termX / 2) - (length / 2))
end

function drawing:centerText_X(str, yPos, color)
    if not color then
        color = colors.white
    end

    local length = str:len()
    local xPos = (math.floor(termX / 2) - math.floor(length / 2))
    term.setCursorPos(xPos, yPos)
    term.setTextColor(color)
    term.write(str)
end

function drawing:drawStart()
    term.setBackgroundColor(colors.gray)
    term.clear()
    term.setCursorPos(1,1)
    paintutils.drawLine(1, 1, termX, 1, colors.blue)
    drawing.centerText_X(self, "Remote Keyboard", 1)
    term.setCursorPos(termX, 1)
    term.write("X")
end

function drawing:drawStatus(status)
    term.setBackgroundColor(colors.gray)
    term.setTextColor(colors.lime)
    paintutils.drawLine(1, 2, termX, 2, colors.gray)
    term.setCursorPos(1,2)
    term.write("Status: "..status)
end

return drawing