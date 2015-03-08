if SERVER then
	AddCSLuaFile("shared.lua")
end

SWEP.HoldType = "ar2"

if CLIENT then
	SWEP.PrintName = "AUG"			
	SWEP.Slot = 0
	SWEP.SlotPos = 1
	SWEP.ViewModelFOV = 55
	SWEP.ViewModelFlip = false
	SWEP.killFont = "weaponSelectionFont_CSS"
	SWEP.WeaponSlot = 1
	SWEP.IconLetter = "e"
	killicon.AddFont("weapon_zs_aug", "CSKillIcons", SWEP.IconLetter, Color(255, 255, 255, 255 ))
end

SWEP.Base				= "weapon_zs_base"

SWEP.WeaponHoldType = "smg"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/cstrike/c_rif_aug.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_aug.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("Weapon_AUG.Single")
SWEP.Primary.Recoil			= 1.25
SWEP.Primary.Unrecoil		= 8
SWEP.Primary.Damage			= 8
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.11
SWEP.Primary.DefaultClip	= SWEP.Primary.ClipSize * 5
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ar2"
SWEP.Primary.ConeMax		= 0.15
SWEP.Primary.ConeMin		= 0.035

SWEP.CSMuzzleFlashes = true



SWEP.IronSightsPos = Vector( -5, -8, 2 )
SWEP.IronSightsAng = Vector( 0, 0, 0 )