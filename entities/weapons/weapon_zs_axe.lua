AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Axe"

	SWEP.ViewModelFOV = 55
	SWEP.ViewModelFlip = false
	SWEP.killFont = "weaponSelectionFont_HL2"
	SWEP.WeaponSlot = 3
	SWEP.IconLetter = "6"
	killicon.AddFont( "weapon_zs_axe", "CSKillIcons", SWEP.IconLetter, Color(255, 80, 0, 255 ) ) 
	SWEP.ShowViewModel = false
	SWEP.ShowWorldModel = false
	SWEP.VElements = {
		["base"] = { type = "Model", model = "models/props/cs_militia/axe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 1.299, -4), angle = Angle(0, 0, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.WElements = {
		["base"] = { type = "Model", model = "models/props/cs_militia/axe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3, 1.399, -4), angle = Angle(0, 0, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Base = "weapon_zs_basemelee"

//Models paths
SWEP.Author = "Deluvas"--Edited by NECROSSIN
SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/props/cs_militia/axe.mdl"
SWEP.UseHands = true


//Name and fov
SWEP.PrintName = "Crowbar"
SWEP.ViewModelFOV = 57

//Position
SWEP.Slot = 2
SWEP.SlotPos = 6

//Damage, distane, delay
SWEP.Primary.Damage = 50
SWEP.Primary.Delay = 1.2
SWEP.Primary.Distance = 70
SWEP.UseHands			= true
SWEP.HitSound = Sound ( "weapons/melee/golf club/golf_hit-0"..math.random(1, 4)..".wav" )
SWEP.MissSound = Sound( "Weapon_Crowbar.Single" )
SWEP.HitRest = Sound( "weapons/melee/golf club/golf_hit-0"..math.random(1, 4)..".wav" )
SWEP.SwingTime = 0.6
SWEP.AttackAnim = ACT_VM_HITCENTER
SWEP.MissAnim = ACT_VM_MISSCENTER

SWEP.HoldType = "melee2"

SWEP.SwingRotation = Angle(30, -30, -30)




--self.HitSound = Sound( "weapons/knife/knife_slash"..i..".wav" )

 