if SERVER then
	AddCSLuaFile("shared.lua")
end

SWEP.HoldType = "duel"

if CLIENT then
	SWEP.PrintName = "Dual Elites"			
	SWEP.Author	= "Rob"
	SWEP.Slot = 1
	SWEP.SlotPos = 1
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 70
	SWEP.killFont = "weaponSelectionFont_CSS"
	SWEP.WeaponSlot = 2
	SWEP.IconLetter = "s"
	killicon.AddFont("weapon_zs_elites", "CSKillIcons", SWEP.IconLetter, Color(255, 255, 255, 255 ))
end

SWEP.Base				= "weapon_zs_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/cstrike/c_pist_elite.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_elite.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("Weapon_ELITE.Single")
SWEP.Primary.Recoil			= 2.5
SWEP.Primary.Damage			= 14
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.12
SWEP.Primary.DefaultClip	= SWEP.Primary.ClipSize * 5
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"
SWEP.Primary.ConeMax		= 0.14
SWEP.Primary.ConeMin		= 0.05

SWEP.CSMuzzleFlashes = true


SWEP.IronSightsPos = Vector( 0,-7 ,0.5 )
SWEP.IronSightsAng = Vector(0,0,0)



