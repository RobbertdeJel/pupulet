if SERVER then
	AddCSLuaFile("shared.lua")
end

SWEP.HoldType = "shotgun"

if CLIENT then
	SWEP.PrintName = "SAW"			
	SWEP.Slot = 0
	SWEP.SlotPos = 1
	SWEP.ViewModelFOV = 65
	SWEP.ViewModelFlip = false
	SWEP.killFont = "weaponSelectionFont_CSS_Big"
	SWEP.WeaponSlot = 1
	SWEP.IconLetter = "z"
	killicon.AddFont("weapon_zs_m249", "CSKillIcons", "z", Color(255, 255, 255, 255 ))
end

SWEP.HoldType = "ar2"
SWEP.Base				= "weapon_zs_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel			= "models/weapons/w_mach_m249para.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("Weapon_M249.Single")
SWEP.Primary.Recoil			= 4
SWEP.Primary.Unrecoil		= 9
SWEP.Primary.Damage			= 14
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 100
SWEP.Primary.Delay			= 0.08
SWEP.Primary.DefaultClip	= SWEP.Primary.ClipSize * 3
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ar2"
SWEP.Primary.ConeMax		= 0.16
SWEP.Primary.ConeMin		= 0.055

SWEP.CSMuzzleFlashes = true


SWEP.IronSightsPos = Vector( -6, -9, 2.3 )
SWEP.IronSightsAng = Vector(0, 0, 0)