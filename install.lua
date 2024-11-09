local baseUri = "https://raw.githubusercontent.com/Ashwintomar/cc-music-player/main/"
local files = { "help", "play", "save", "savetodevice", "startup", "menu", "setvolume" }

term.clear()

for _, file in pairs(files) do
    print("Downloading program '" .. file .. "'...")

    local fileInstance = fs.open(file .. ".lua", "w")
    local response = http.get(baseUri .. file .. ".lua")

    if response then
        fileInstance.write(response.readAll())
        fileInstance.close()
    else
        print("Failed to download '" .. file .. "'.")
    end
end

local updateUri = "https://raw.githubusercontent.com/Ashwintomar/cc-music-player/main/version.txt"

local updateResponse = http.get(updateUri)
if updateResponse then
    local updateFile = fs.open("version.txt", "w")
    updateFile.write(updateResponse.readAll())
    updateFile.close()
else
    print("Failed to download version file.")
end

print("Installation complete! Please restart your computer.")