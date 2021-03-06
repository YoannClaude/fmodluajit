local fmod
local ffi = require"ffi"

ffi.cdef[[

    bool InitFmod();
    bool UpdateFmod();
    bool ReleaseFmod();

    int LoadBank(const char* path);
    
    int GetBus(const char* path);
    bool SetBusVolume(int key, float value);
    float GetBusVolume(int key);
    bool SetBusMute(int key, bool mute);
    bool GetBusMute(int key);

    int GetVCA(const char* path);
    bool SetVcaVolume(int key, float value);
    float GetVcaVolume(int key);

    int CreateInstance(const char* path);
    bool PlayOneShotEvent(const char* path);
    bool PlayEvent(int key);
    bool StopEvent(int key);
    bool PauseEvent(int key, bool paused);
    bool EventIsPlaying(int key);

    bool SetParamaterByName(int key, const char* name, float value);
    float GetParameterByName(int key, const char* name);
    bool SetGlobalParamaterByName(const char* name, float value);
    float GetGlobalParameterByName(const char* name);

]]

local init = function()
    if ffi.os == "Windows" then
        fmod = ffi.load("fmodluajit.dll")
    elseif ffi.os == "Linux" then
        fmod = ffi.load("libs/linux/libfmodluajit.so")
    elseif ffi.os == "OSX" then
        fmod = ffi.load("libs/macos/libfmodluajit.dylib")
    end
    if fmod.InitFmod() then print"FMOD STUDIO Init" end
end

return function()
    return {
        init = init,
        update = function() return fmod.UpdateFmod() end,
        release = function() if fmod.ReleaseFmod() then print"FMOD STUDIO Release" end end,
        load_bank = function(path) return fmod.LoadBank(path) end,
        get_bus = function(path) return fmod.GetBus(path) end,
        set_bus_volume = function(key, value) return fmod.SetBusVolume(key, value) end,
        get_bus_volume = function(key) return fmod.GetBusVolume(key) end,
        set_bus_mute = function(key, mute) return fmod.SetBusMute(key, mute) end,
        get_bus_mute = function(key) return fmod.GetBusMute(key) end,
        get_vca = function(path) return fmod.GetVCA(path) end,
        set_vca_volume = function(key, value) return fmod.SetVcaVolume(key, value) end,
        get_vca_volume = function(key) return fmod.GetVcaVolume(key) end,
        create_instance = function(path) return fmod.CreateInstance(path) end,
        play_one_shot_event = function(path) return fmod.PlayOneShotEvent(path) end,
        play_event = function(key) return fmod.PlayEvent(key) end,
        stop_event = function(key) return fmod.StopEvent(key) end,
        pause_event = function(key, paused) return fmod.PauseEvent(key, paused) end,
        event_is_playing = function(key) return fmod.EventIsPlaying(key) end,
        set_parameter_by_name = function(key, name, value) return fmod.SetParamaterByName(key, name, value) end,
        get_paramater_by_name = function(key, name) return fmod.GetParameterByName(key, name) end,
        set_global_parameter_by_name = function(name, value) return fmod.SetGlobalParamaterByName(name, value) end,
        get_global_paramater_by_name = function(name) return fmod.GetGlobalParameterByName(name) end
    }
end
