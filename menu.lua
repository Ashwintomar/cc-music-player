local w, h = term.getSize()
local selectedEntry = 1

local menus = {}
local currentMenu = "main"
local running = true

function render()
    term.clear()
    term.setCursorPos(1, 1)

    local menu = menus[currentMenu] or menus["main"]

    if selectedEntry > #menu.entries then
        selectedEntry = 1
    elseif selectedEntry < 1 then
        selectedEntry = #menu.entries
    end

    if currentMenu ~= "main" then
        table.insert(menu.entries, {
            label = "[BACK]",
            callback = function()
                currentMenu = menu.parent or "main"
                selectedEntry = 1
                render()
            end
        })
    end

    for i = 1, #menu.entries do
        local caret = selectedEntry == i and ">> " or "   "
        term.setTextColor(selectedEntry == i and colors.magenta or colors.white)
        print(caret .. menu.entries[i].label)
    end
end

function onKeyPress(key)
    local menu = menus[currentMenu] or menus["main"]

    local switch = (({
        [keys.enter] = function()
            if menu.entries[selectedEntry].callback then
                menu.entries[selectedEntry].callback()
            end
        end,

        [keys.up] = function()
            selectedEntry = selectedEntry - 1
        end,

        [keys.down] = function()
            selectedEntry = selectedEntry + 1
        end
    })[key] or function() end)()

    if selectedEntry > #menu.entries then
        selectedEntry = 1
    elseif selectedEntry < 1 then
        selectedEntry = #menu.entries
    end

    render()
end

function thread()
    while running do
        local event, key = os.pullEvent("key")
        onKeyPress(key)
    end
end

return {
    init = function(m) menus = m end,
    exit = function() running = false end,
    render = render,
    thread = thread
}