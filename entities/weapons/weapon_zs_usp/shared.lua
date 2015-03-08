if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "USP"
	SWEP.Author	= "Rob"
	SWEP.SlotPos = 2
	SWEP.ViewModelFOV = 68
	SWEP.ViewModelFlip = false
	SWEP.IconLetter = "a"
	SWEP.killFont = "weaponSelectionFont_CSS"
	SWEP.WeaponSlot = 2
	SWEP.Slot = 1
	killicon.AddFont( "weapon_zs_usp", "CSKillIcons", SWEP.IconLetter, Color(255, 255, 255, 255 ) )
end
SWEP.HoldType = "pistol"
SWEP.Base				= "weapon_zs_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/cstrike/c_pist_usp.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_usp.mdl"

SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.Primary.Sound			= Sound( "Weapon_USP.Single" )
SWEP.Primary.Recoil			= 2.25
SWEP.Primary.Damage			= 11
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 12
SWEP.Primary.Delay			= 0.15
SWEP.Primary.DefaultClip	= SWEP.Primary.ClipSize * 5
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"

SWEP.Primary.ConeMax		= 0.12
SWEP.Primary.ConeMin		= 0.041

SWEP.CSMuzzleFlashes = true


SWEP.IronSightsPos = Vector(-5.921, -3.417, 1.68)
