local URL = "https://raw.githubusercontent.com/SynicalMX/cc-remote-keyboard/main/src/"

local function downloadFile(path)
    local url = URL..path

    local http_handle, err = http.get(url)
    if err then
        print("Retrying download...")
        sleep(0.5)
        downloadFile(path)
        return
    end
    local file_handle = fs.open("/keyboard/"..path, "w")

    file_handle.write(http_handle.readAll())
    
    file_handle.close()
    http_handle.close()
end

downloadFile("main.lua")
downloadFile("drawing.lua")
downloadFile("buttons.lua")
