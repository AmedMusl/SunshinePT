ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")

CUR_INDEX = -1
SLOT_DATA = nil

function has_value (t, val)
    for i, v in ipairs(t) do
        if v == val then return 1 end
    end
    return 0
end

function dump_table(o, depth)
    if depth == nil then
        depth = 0
    end
    if type(o) == 'table' then
        local tabs = ('\t'):rep(depth)
        local tabs2 = ('\t'):rep(depth + 1)
        local s = '{\n'
        for k, v in pairs(o) do
            if type(k) ~= 'number' then
                k = '"' .. k .. '"'
            end
            s = s .. tabs2 .. '[' .. k .. '] = ' .. dump_table(v, depth + 1) .. ',\n'
        end
        return s .. tabs .. '}'
    else
        return tostring(o)
    end
end

function onClear(slot_data)
    SLOT_DATA = slot_data
    CUR_INDEX = -1
    print(dump_table(slot_data))
    -- for k, v in pairs(LOCATION_MAPPING) do
    --     local loc_list = LOCATION_MAPPING[k]
    --     for i, loc in ipairs(loc_list) do
    --         local obj = Tracker:FindObjectForCode(loc)
    --         if obj then
    --             if loc:sub(1, 1) == "@" then
    --                 obj.AvailableChestCount = obj.ChestCount
    --             else
    --                 obj.Active = false
    --             end
    --         end
    --     end
    -- end

    if slot_data['blue_coin_sanity'] then
        local bluesanity = Tracker:FindObjectForCode("blues")
        bluesanity.CurrentStage = (slot_data['blue_coin_sanity'])
    end

    if slot_data['starting_nozzle'] then
        local nozzletype = Tracker:FindObjectForCode("nozzlestart")
        nozzletype.CurrentStage = (slot_data['starting_nozzle'])
    end

    if slot_data['corona_mountain_shines'] then
        local coronashines = Tracker:FindObjectForCode('coronashines')
        coronashines.AcquiredCount = (slot_data['corona_mountain_shines'])
    end

    if slot_data['yoshi_mode'] then
        local yoshster = Tracker:FindObjectForCode('yoshistart')
        yoshster.CurrentStage = (slot_data['yoshi_mode'])
    end

    if slot_data['ticket_mode'] then
        local ticketing = Tracker:FindObjectForCode("progression")
        ticketing.CurrentStage = (slot_data['ticket_mode'])
    end
end

function onItem(index, item_id, item_name, player_number)
    if index <= CUR_INDEX then
        return
    end
    local is_local = player_number == Archipelago.PlayerNumber
    CUR_INDEX = index;
    local v = ITEM_MAPPING[item_id]
    if not v or not v[1] then
        --print(string.format("onItem: could not find item mapping for id %s", item_id))
        return
    end
    local obj = Tracker:FindObjectForCode(v[1])
    if obj then
        if v[2] == "toggle" then
            obj.Active = true
        elseif v[2] == "progressive" then
            if obj.Active then
                obj.CurrentStage = obj.CurrentStage + 1
            else
                obj.Active = true
            end
        elseif v[2] == "consumable" then
            obj.AcquiredCount = obj.AcquiredCount + obj.Increment
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: unknown item type %s for code %s", v[2], v[1]))
        end
    else
        print(string.format("onItem: could not find object for code %s", v[1]))
    end
end

function onLocation(location_id, location_name)
    local loc_list = LOCATION_MAPPING[location_id]

    for i, loc in ipairs(loc_list) do
        if not loc then
            return
        end
        local obj = Tracker:FindObjectForCode(loc)
        if obj then
            if loc:sub(1, 1) == "@" then
                obj.AvailableChestCount = obj.AvailableChestCount - 1
            else
                obj.Active = true
            end
        end
    end
end



Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)