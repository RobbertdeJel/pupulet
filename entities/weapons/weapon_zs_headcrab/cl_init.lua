include("shared.lua")

SWEP.PrintName = "Headcrab"
SWEP.ViewModelFOV = 70
SWEP.DrawCrosshair = false

function SWEP:Reload()
end

function SWEP:DrawWorldModel()
end
SWEP.DrawWorldModelTranslucent = SWEP.DrawWorldModel

function SWEP:DrawHUD()
end
