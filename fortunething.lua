local KEYBIND = 'B' -- change the keybind to whatever you want

if renderdupe then 
    warn('[!] dupe already loaded!')
    return task.wait(9e9);
end;

local cloneref = cloneref or function(data: userdata) return data end;
local dupetoggled = true;
local getservice = function(service: string)
    return cloneref(game:FindService(service));
end;

local getrandomvalue = function(tab: table)
    return #tab > 0 and tab[math.random(1, #tab)] or ''
end;

local remote = getservice('ReplicatedStorage'):WaitForChild('rbxts_include'):WaitForChild('node_modules'):WaitForChild('@rbxts'):WaitForChild('net'):WaitForChild('out'):WaitForChild('_NetManaged'):WaitForChild('RequestFortuneCashOut');

task.spawn(function()
    repeat 
        task.wait()
        if not dupetoggled then 
            continue
        end;
        remote:FireServer({
            statusEffectType = 'fortune_1',
            fortuneStacks = getrandomvalue({700, 9e9})
        })
    until false;
end);

getservice('UserInputService').InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode[KEYBIND] and inputservice:GetFocusedTextBox() == nil then 
        dupetoggled = not dupetoggled;
        getservice('StarterGui'):SetCore('SendNotification', {
            Title = 'Render',
            Text = `Dupe status has been set to {tostring(dupetoggled):upper()}!.`,
            Duration = 8,
        })
    end
end)

getservice('StarterGui'):SetCore('SendNotification', {
    Title = 'Render',
    Text = `Dupe loaded, press {KEYBIND} on your keyboard to toggle.`,
    Duration = 8,
})

getgenv().renderdupe = true
