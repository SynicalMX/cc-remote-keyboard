local URL = "https://raw.githubusercontent.com/SynicalMX/cc-remote-keyboard/main/src/"

local function downloadFile(path, lib)
    local url = URL..path
    local filepath = "/"
    if lib then
        filepath = filepath.."keyboard/"
    end

    local http_handle, err = http.get(url)
    if err then
        print("Retrying download...")
        sleep(0.5)
        downloadFile(path)
        return
    end
    local file_handle = fs.open(filepath..path, "w")

    file_handle.write(http_handle.readAll())
    
    file_handle.close()
    http_handle.close()
end

downloadFile("client.lua", true)
downloadFile("remote.lua", false)