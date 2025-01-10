-- put logic functions here using the Lua API: https://github.com/black-sliver/PopTracker/blob/master/doc/PACKS.md#lua-interface
-- don't be afraid to use custom logic functions. it will make many things a lot easier to maintain, for example by adding logging.
-- to see how this function gets called, check: locations/locations.json
-- example:
function has_more_then_n_consumable(n)
    local count = Tracker:ProviderCountForCode('consumable')
    local val = (count > tonumber(n))
    if ENABLE_DEBUG_LOG then
        print(string.format("called has_more_then_n_consumable: count: %s, n: %s, val: %s", count, n, val))
    end
    if val then
        return 1 -- 1 => access is in logic
    end
    return 0 -- 0 => no access
end
function has(item, amount)
    local count = Tracker:ProviderCountForCode(item)
    amount = tonumber(amount)
    if not amount then
        return count > 0
    else
        return count >= amount
    end
end

levelaccess = Tracker:FindObjectForCode("progression")
bluecoinsenabled = Tracker:FindObjectForCode("blue_coin_sanity")
coin_shine_enabled = Tracker:FindObjectForCode("coin_shine_enabled")

-- Shine Counter
function shines()
    return Tracker:ProviderCountForCode("shine")
end
function shinecount(targetshines)
    return shines() >= tonumber(targetshines)
end
function blues()
    return Tracker:ProviderCountForCode("blue")
end
function bluecount(targetblues)
    return blues() >= tonumber(targetblues)
end
function hascoronashines()
    if Tracker:ProviderCountForCode("shine") >= Tracker:ProviderCountForCode("coronashines") then
        return true
    end
end

-- Moves
function spray()
    return has("fludd")
end

function hover()
    return has("hover")
end

function turbo()
   return has("turbo") 
end

function rocket()
    return has("rocket")
end

-- Yoshi Logic

function isPinnaEnterable()
    if has("progression") == has("progression_ticket") then
        return has("pinna")
    elseif has("progression") == has("progression_vanilla") then
        return shines() >= 10
    end
end

function Pinna4()
    return has("fludd") and has("hover")
end

function yoshi()
    if has("yoshistart") == has("skip_pinna") then
        return has("yoshi")
    elseif has("yoshistart") == has("plaza_only") then
        return isPinnaEnterable() and Pinna4()
    end
end

-- General Items

function splasher()
    return has("fludd") or has("hover")
end

function height()
    return has("hover") or has("rocket")
end

function speed()
    return has("spray") or has("turbo")
end

function squirter()
    return has("spray") or has("yoshi")
end


function skipintro()
    return has("nozzlefluddless")
end

-- Entrance Functions
-- Function for Corona and Airstrip Entrances

function iscoronaenterable()
    return hascoronashines()
end

-- Bianco

function isBiancoEnterable()
    if has("progression") == has("progression_ticket") then
        return has("bianco")
    elseif has("progression") == has("progression_vanilla") then
        return has("fludd")
    end
end

function Bianco4()
    return has("fludd") and has("hover") or has("rocket")
end

function Bianco5()
    return has("fludd") and has("hover") or has("rocket")
end

function Bianco6()
    return has("fludd") and has("hover") and has("rocket")
end

-- Ricco

function isRiccoEnterable()
    if has("progression") == has("progression_ticket") then
        return has("ricco")
    elseif has("progression") == has("progression_vanilla") then
        return has("fludd") and shines() >= 3
    end
end

function Ricco47()
    return has("hover")
end

-- Gelato

function isGelatoEnterable()
    if has("progression") == has("progression_ticket") then
        return has("gelato")
    elseif has("progression") == has("progression_vanilla") then
        return has("fludd") and shines() >= 5
    end
end

--Sirena

function isSirenaEnterable()
    if has("progression") == has("progression_ticket") then
        return has("sirena")
    elseif has("progression") == has("progression_vanilla") then
        return has("yoshi")
    end
end

--Noki

function isNokiEnterable()
    if has("progression") == has("progression_ticket") then
        return has("noki")
    elseif has("progression") == has("progression_vanilla") then
        return shines() >= 20
    end
end

-- Pianta

function isPiantaEnterable()
    if has("progression") == has("progression_ticket") then
        return has("pianta") and has("rocket")
    elseif has("progression") == has("progression_vanilla") then
        return shines() >= 10 and has("rocket")
    end
end

-- Boathouse

function BH1()
    if has("blues") == has("blues_on") or has("blues_boathouse") then
        return blues() >= 10
    end
end

function BH2()
    if has("blues") == has("blues_on") or has("blues_boathouse") then
        return blues() >= 20
    end
end

function BH3()
    if has("blues") == has("blues_on") or has("blues_boathouse") then
        return blues() >= 30
    end
end

function BH4()
    if has("blues") == has("blues_on") or has("blues_boathouse") then
        return blues() >= 40
    end
end
function BH5()
    if has("blues") == has("blues_on") or has("blues_boathouse") then
        return blues() >= 50
    end
end

function BH6()
    if has("blues") == has("blues_on") or has("blues_boathouse") then
        return blues() >= 60
    end
end

function BH7()
    if has("blues") == has("blues_on") or has("blues_boathouse") then
        return blues() >= 70
    end
end

function BH8()
    if has("blues") == has("blues_on") or has("blues_boathouse") then
        return blues() >= 80
    end
end

function BH9()
    if has("blues") == has("blues_on") or has("blues_boathouse") then
        return blues() >= 90
    end
end

function BH10()
    if has("blues") == has("blues_on") or has("blues_boathouse") then
        return blues() >= 100
    end
end

function BH11()
    if has("blues") == has("blues_on") or has("blues_boathouse") then
        return blues() >= 110
    end
end

function BH12()
    if has("blues") == has("blues_on") or has("blues_boathouse") then
        return blues() >= 120
    end
end

function BH13()
    if has("blues") == has("blues_on") or has("blues_boathouse") then
        return blues() >= 130
    end
end

function BH14()
    if has("blues") == has("blues_on") or has("blues_boathouse") then
        return blues() >= 140
    end
end

function BH15()
    if has("blues") == has("blues_on") or has("blues_boathouse") then
        return blues() >= 150
    end
end

function BH16()
    if has("blues") == has("blues_on") or has("blues_boathouse") then
        return blues() >= 160
    end
end

function BH17()
    if has("blues") == has("blues_on") or has("blues_boathouse") then
        return blues() >= 170
    end
end

function BH18()
    if has("blues") == has("blues_on") or has("blues_boathouse") then
        return blues() >= 180
    end
end

function BH19()
    if has("blues") == has("blues_on") or has("blues_boathouse") then
        return blues() >= 190
    end
end

function BH20()
    if has("blues") == has("blues_on") or has("blues_boathouse") then
        return blues() >= 200
    end
end

function BH21()
    if has("blues") == has("blues_on") or has("blues_boathouse") then
        return blues() >= 210
    end
end

function BH22()
    if has("blues") == has("blues_on") or has("blues_boathouse") then
        return blues() >= 220
    end
end

function BH23()
    if has("blues") == has("blues_on") or has("blues_boathouse") then
        return blues() >= 230
    end
end

function BH24()
    if has("blues") == has("blues_on") or has("blues_boathouse") then
        return blues() >= 240
    end
end