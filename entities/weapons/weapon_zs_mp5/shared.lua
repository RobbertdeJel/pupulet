if SERVER then
	AddCSLuaFile("shared.lua")
end

SWEP.HoldType = "smg"

if CLIENT then
	SWEP.PrintName = "MP5"			
	SWEP.Slot = 0
	SWEP.SlotPos = 1
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 55
	SWEP.killFont = "weaponSelectionFont_CSS"
	SWEP.WeaponSlot = 1
	SWEP.IconLetter = "x"
	killicon.AddFont("weapon_zs_mp5", "CSKillIcons", SWEP.IconLetter, Color(255, 255, 255, 255 ))
end

SWEP.Base				= "weapon_zs_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/cstrike/c_smg_mp5.mdl"
SWEP.WorldModel			= "models/weapons/w_smg_mp5.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("Weapon_MP5Navy.Single")
SWEP.Primary.Recoil			= 2.2
SWEP.Primary.Damage			= 12
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.09
SWEP.Primary.DefaultClip	= SWEP.Primary.ClipSize * 5
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SMG1"

SWEP.Primary.ConeMax		= 0.11
SWEP.Primary.ConeMin		= 0.035

SWEP.CSMuzzleFlashes = true


SWEP.IronSightsPos = Vector( -5.3, -8, 2 )
SWEP.IronSightsAng = Vector( 0, 0, 0 )