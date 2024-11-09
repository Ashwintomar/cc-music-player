local arg = { ... }

if arg[2] ~= nil then
    if peripheral.isPresent("drive") then
        local file = fs.open("disk/song.txt", "w")

        peripheral.find("drive").setDiskLabel(arg[1])

        file.write(arg[2])

        print("Successfully wrote song to floppy.")

        file.close()
    else
        print("No valid disk drive was found.")
        print("You will have to save files to the device using 'savetodevice', or connect a disk drive.")
    end
else
    print("Invalid syntax!")
    print("Correct syntax: save <song name> <song url>")
end