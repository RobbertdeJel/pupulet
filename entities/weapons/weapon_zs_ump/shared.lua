if SERVER then
	AddCSLuaFile("shared.lua")
end

SWEP.HoldType = "smg"

if CLIENT then
	SWEP.PrintName = "UMP-45"			
	SWEP.SlotPos = 1
	SWEP.IconLetter = "q"
	
	SWEP.killFont = "weaponSelectionFont_CSS"
	SWEP.WeaponSlot = 3
	SWEP.Slot = 2
	killicon.AddFont("weapon_zs_ump", "CSKillIcons", SWEP.IconLetter, Color(255, 255, 255, 255 ))
	SWEP.ViewModelFlip = true
end

SWEP.Base				= "weapon_zs_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_smg_ump45.mdl"
SWEP.WorldModel			= "models/weapons/w_smg_ump45.mdl"

SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("Weapon_UMP45.Single")
SWEP.Primary.Recoil			= 4.5
SWEP.Primary.Damage			= 20
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 25
SWEP.Primary.Delay			= 0.12
SWEP.Primary.DefaultClip	= SWEP.Primary.ClipSize * 5
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SMG1"

SWEP.Primary.ConeMax		= 0.14
SWEP.Primary.ConeMin		= 0.041

SWEP.CSMuzzleFlashes = true


SWEP.IronSightsPos 		= Vector( 5, -11, 3 )
SWEP.IronSightsAng 		= Vector( 0, 0, 0 )