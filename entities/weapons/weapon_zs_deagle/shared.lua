if SERVER then
	AddCSLuaFile("shared.lua")
end

SWEP.HoldType = "pistol"

if CLIENT then
	SWEP.PrintName = "Desert Eagle"			
	SWEP.Slot = 1
	SWEP.SlotPos = 3
	SWEP.ViewModelFlip = false 
	SWEP.IconLetter = "f"
	SWEP.killFont = "weaponSelectionFont_CSS"
	SWEP.WeaponSlot = 2
	SWEP.Slot = 1
	killicon.AddFont( "weapon_zs_deagle", "CSKillIcons", SWEP.IconLetter, Color(255, 255, 255, 255 ) )
end

SWEP.Base				= "weapon_zs_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_deagle.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("Weapon_Deagle.Single")
SWEP.Primary.Recoil			= 3.25
SWEP.Primary.Damage			= 28
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 7
SWEP.Primary.Delay			= 0.3
SWEP.Primary.DefaultClip	= SWEP.Primary.ClipSize * 5
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"
SWEP.Primary.ConeMax		= 0.13
SWEP.Primary.ConeMin		= 0.04

SWEP.CSMuzzleFlashes = true
 

SWEP.IronSightsPos = Vector( -6.4, -1.8, 2 )
SWEP.IronSightsAng = Vector( 0, 0, 0 )

