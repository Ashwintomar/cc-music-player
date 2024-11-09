local args = { ... }

if args[1] == nil or tonumber(args[1]) == nil then
    print("ERR - Please enter a number value between 0 and 100.")
else
    local volume = tonumber(args[1])
    if volume < 0 or volume > 100 then
        print("ERR - Volume must be between 0 and 100.")
    else
        local actualVolume = (volume / 100) * 3

        settings.set("media_center.volume", actualVolume)

        print("Set the volume to " .. volume .. "%")
    end
end