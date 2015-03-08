if SERVER then
	AddCSLuaFile("shared.lua")
end

SWEP.HoldType = "shotgun"

if CLIENT then
	SWEP.PrintName = "M3"
	SWEP.Author	= "Rob"
	SWEP.Slot = 0
	SWEP.SlotPos = 1
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 60
	SWEP.killFont = "weaponSelectionFont_CSS_Big"
	SWEP.WeaponSlot = 1
	SWEP.IconLetter = "k"
	killicon.AddFont("weapon_zs_m3", "CSKillIcons", SWEP.IconLetter, Color(255, 255, 255, 255 ))
end

SWEP.Base				= "weapon_zs_base_shotgun"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/cstrike/c_shot_m3super90.mdl"
SWEP.WorldModel			= "models/weapons/w_shot_m3super90.mdl"

SWEP.Weight				= 10
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("Weapon_M3.Single")
SWEP.Primary.Recoil			= 5
SWEP.Primary.Damage			= 9
SWEP.Primary.NumShots		= 10
SWEP.Primary.ClipSize		= 5
SWEP.Primary.Delay 			= 0.95
SWEP.Primary.DefaultClip	= SWEP.Primary.ClipSize*5
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "buckshot"
SWEP.Primary.ConeMax		= 0.16
SWEP.Primary.ConeMin		= 0.12

SWEP.CSMuzzleFlashes = true



SWEP.IronSightsPos = Vector(-3.73,-4,1.375)
SWEP.IronSightsAng = Vector( 0, 0, 0 )











