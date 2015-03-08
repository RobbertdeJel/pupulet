if SERVER then
	AddCSLuaFile("shared.lua")
end

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.PrintName = "M4A1"			
	SWEP.Slot = 0
	SWEP.SlotPos = 1
	SWEP.ViewModelFOV = 55
	SWEP.ViewModelFlip = false 
	SWEP.killFont = "weaponSelectionFont_CSS_Big"
	SWEP.WeaponSlot = 1
	SWEP.IconLetter = "w"
	killicon.AddFont("weapon_zs_m4a1", "CSKillIcons", SWEP.IconLetter, Color(255, 255, 255, 255 ))
end

SWEP.Base				= "weapon_zs_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_m4a1.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("Weapon_M4A1.Single")
SWEP.Primary.Recoil			= 0.25
SWEP.Primary.Unrecoil		= 3
SWEP.Primary.Damage			= 16
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.14
SWEP.Primary.DefaultClip	= SWEP.Primary.ClipSize * 5
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ar2"
SWEP.Primary.ConeMax		= 0.12
SWEP.Primary.ConeMin		= 0.042

SWEP.CSMuzzleFlashes = true


SWEP.IronSightsPos = Vector( -5, -9, 1.0 )
SWEP.IronSightsAng = Vector(0,0,0)