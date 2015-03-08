AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Pot"

	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 55

	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false

	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/props_interiors/pot02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 1.363, -6.818), angle = Angle(0, 90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/props_interiors/pot02a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 1.363, -6.818), angle = Angle(0, 90, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

//Models paths
SWEP.Author = "Rob"
SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/props_interiors/pot02a.mdl"
SWEP.UseHands = true


//Name and fov
SWEP.PrintName = "Crowbar"
SWEP.ViewModelFOV = 57

//Position
SWEP.Slot = 2
SWEP.SlotPos = 6

//Damage, distane, delay
SWEP.Primary.Damage = 35
SWEP.Primary.Delay = 0.7
SWEP.Primary.Distance = 70
SWEP.UseHands			= true
SWEP.HitSound = Sound ( "weapons/melee/frying_pan/pan_hit-0"..math.random(4)..".ogg" )
SWEP.MissSound = Sound( "Weapon_Crowbar.Single" )
SWEP.HitRest = Sound( "weapons/melee/frying_pan/pan_hit-0"..math.random(4)..".ogg" )
SWEP.SwingTime = 0.2
SWEP.AttackAnim = ACT_VM_HITCENTER
SWEP.MissAnim = ACT_VM_MISSCENTER

SWEP.HoldType = "melee"

SWEP.SwingRotation = Angle(30, -30, -30)


function SWEP:Precache()
	util.PrecacheSound("weapons/knife/knife_slash1.wav")
	util.PrecacheSound("weapons/knife/knife_slash2.wav")
end




--self.HitSound = Sound( "weapons/knife/knife_slash"..i..".wav" )

 