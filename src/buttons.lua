local buttons = {}
local _buttons = {}

function buttons:createButton(xmin, ymax, xmax, ymin, func)
    local button = {
        ["xmin"] = xmin,
        ["ymax"] = ymax,
        ["xmax"] = xmax,
        ["ymin"] = ymin,
        ["func"] = func
    }

    local tableSize = #_buttons
    _buttons[tableSize+1] = button
end

function buttons:update(x, y)
    for _, button in pairs(_buttons) do
        if button["xmin"] <= x and button["xmax"] >= x and button["ymin"] <= y and button["ymax"] >= y then
            button["func"]()
        end
    end
end

return buttons