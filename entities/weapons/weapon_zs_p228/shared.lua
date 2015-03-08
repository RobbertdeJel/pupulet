if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "P228"
	SWEP.Author	= "Rob"
	SWEP.Slot = 1
	SWEP.ViewModelFOV = 68
	SWEP.SlotPos = 1
	SWEP.ViewModelFlip = false
	SWEP.killFont = "weaponSelectionFont_CSS"
	SWEP.WeaponSlot = 2
	SWEP.IconLetter = "a"
	killicon.AddFont("weapon_zs_p228", "CSKillIcons", SWEP.IconLetter, Color(255, 255, 255, 255 ))
end

SWEP.Base				= "weapon_zs_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/cstrike/c_pist_p228.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_p228.mdl"

SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("Weapon_P228.Single")
SWEP.Primary.Recoil			= 2.25
SWEP.Primary.Damage			= 11
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 15
SWEP.Primary.Delay			= 0.15
SWEP.Primary.DefaultClip	= SWEP.Primary.ClipSize * 5
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"
SWEP.Primary.ConeMax		= 0.08
SWEP.Primary.ConeMin		= 0.032


SWEP.CSMuzzleFlashes = true

SWEP.IronSightsPos = Vector(-6, 2, 1 )
SWEP.IronSightsAng 	= Vector ( -12, 0, 0 )

SWEP.HoldType = "pistol"
