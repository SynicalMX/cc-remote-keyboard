local URL = "https://raw.githubusercontent.com/SynicalMX/cc-remote-keyboard/master/src/"

local function downloadFile(path)
    local url = URL..path

    local http_handle = http.get(url)
    local file_handle = fs.open("/keyboard/"..path, "w")

    file_handle.write(http_handle.readAll())
end

downloadFile("main.lua")
downloadFile("drawings.lua")
downloadFile("buttons.lua")