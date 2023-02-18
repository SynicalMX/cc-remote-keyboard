-- This file is meant to allow the client to use multishell

local id = multishell.launch({}, "/keyboard/client.lua")
multishell.setTitle(id, "Remote Keyboard")
multishell.setFocus(id)