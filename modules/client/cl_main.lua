local flashlightActive = false

CreateThread(function()
    while true do
        Wait(250)  -- Increase wait time to reduce CPU load
        local ped = PlayerPedId()

        -- Ensure the ped exists and is not dead before checking weapon
        if DoesEntityExist(ped) and not IsEntityDead(ped) then
            local currentWeapon = GetSelectedPedWeapon(ped)

            -- Check if the current weapon is in the Config.Weapons table
            local weaponComponent = Config.Weapons[currentWeapon]
            if weaponComponent and HasPedGotWeaponComponent(ped, currentWeapon, weaponComponent) then
                -- Check for key press
                if IsControlJustPressed(0, Config.Keybind) then
                    flashlightActive = not flashlightActive
                    TriggerEvent("persistentweaponflashlight:client:ToggleFlashlight", ped, flashlightActive)
                end
            end
        end
    end
end)

RegisterNetEvent("persistentweaponflashlight:client:ToggleFlashlight")
AddEventHandler("persistentweaponflashlight:client:ToggleFlashlight", function(ped, active)
    SetFlashLightEnabled(ped, active)
    SetFlashLightKeepOnWhileMoving(active)
end)
