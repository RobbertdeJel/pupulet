if SERVER then
	AddCSLuaFile("shared.lua")
end

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.PrintName = "FAMAS"
	SWEP.Author	= "Rob"
	SWEP.Slot = 0
	SWEP.SlotPos = 1
	SWEP.ViewModelFOV = 55
	SWEP.killFont = "weaponSelectionFont_CSS"
	SWEP.WeaponSlot = 2
	SWEP.IconLetter = "t"
	killicon.AddFont("weapon_zs_famas", "CSKillIcons", SWEP.IconLetter, Color(255, 255, 255, 255 ))
end

SWEP.Base				= "weapon_zs_base"
SWEP.ViewModelFlip		= false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/cstrike/c_rif_famas.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_famas.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("Weapon_FAMAS.Single")
SWEP.Primary.Recoil			= 1.1
SWEP.Primary.Unrecoil		= 11
SWEP.Primary.Damage			= 14
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.15
SWEP.Primary.DefaultClip	= SWEP.Primary.ClipSize * 6
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ar2"
SWEP.Primary.ConeMax		= 0.15
SWEP.Primary.ConeMin		= 0.045

SWEP.CSMuzzleFlashes = true


SWEP.IronSightsPos = Vector( -4.8, -12, 3 )
SWEP.IronSightsAng = Vector( 0, 0, 0 )

