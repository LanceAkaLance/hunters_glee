-- kill sandbox stuff

function GM:CanProperty()
    return false

end

if CLIENT then
    local LocalPlayer = LocalPlayer
    function GM:SpawnMenuEnabled()
        return false

    end

    local function doContextMenuOnly()
        -- kill menubar for non-admins
        menubar.glee_oldMenuBarInit = menubar.glee_oldMenuBarInit or menubar.Init
        menubar.Init = function()
            if not IsValid( LocalPlayer() ) then return end
            if not LocalPlayer():IsAdmin() then return end
            menubar.glee_oldMenuBarInit()

        end

        menubar.glee_oldMenuParentTo = menubar.glee_oldMenuParentTo or menubar.ParentTo
        menubar.ParentTo = function( to )
            if not IsValid( LocalPlayer() ) then return end
            if not LocalPlayer():IsAdmin() then return end
            menubar.glee_oldMenuParentTo( to )

        end
        CreateContextMenu()

    end

    hook.Add( "OnGamemodeLoaded", "Glee_CreateSpawnMenu", doContextMenuOnly )

else
    local no = function()
        return false

    end

    hook.Add( "PlayerSpawnObject", "glee_unsandboxify", no )
    hook.Add( "PlayerSpawnEffect", "glee_unsandboxify", no )
    hook.Add( "PlayerSpawnNPC", "glee_unsandboxify", no )
    hook.Add( "PlayerSpawnProp", "glee_unsandboxify", no )
    hook.Add( "PlayerSpawnRagdoll", "glee_unsandboxify", no )
    hook.Add( "PlayerSpawnSENT", "glee_unsandboxify", no )
    hook.Add( "PlayerSpawnSWEP", "glee_unsandboxify", no )
    hook.Add( "PlayerSpawnVehicle", "glee_unsandboxify", no )
    hook.Add( "PlayerGiveSWEP", "glee_unsandboxify", no )
    hook.Add( "CanArmDupe", "glee_unsandboxify", no )
    hook.Add( "CanDrive", "glee_unsandboxify", no )
    hook.Add( "CanTool", "glee_unsandboxify", no )

end