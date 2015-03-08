

if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Galil"			
	SWEP.Author	= "Rob"
	SWEP.SlotPos = 1
	SWEP.ViewModelFlip = true
	SWEP.ViewModelFOV = 50
	SWEP.IconLetter = "v"
	SWEP.killFont = "weaponSelectionFont_CSS_Big"
	SWEP.WeaponSlot = 1
	SWEP.Slot = 0
	killicon.AddFont("weapon_zs_galil", "CSKillIcons", SWEP.IconLetter, Color(255, 255, 255, 255 ))
end


SWEP.Base				= "weapon_zs_base"
SWEP.ViewModelFlip		= false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= Model ( "models/weapons/cstrike/c_rif_galil.mdl" )
SWEP.UseHands = true
SWEP.WorldModel			= Model ( "models/weapons/w_rif_galil.mdl" )

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "ar2"

SWEP.Primary.Sound			= Sound("Weapon_Galil.Single")
SWEP.Primary.Recoil			= 1.5
SWEP.Primary.Damage			= 18
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 30
SWEP.storeclipsize			= 30
SWEP.MaxAmmo			    = 250
SWEP.Primary.Delay			= 0.120
SWEP.Primary.DefaultClip	= 185
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ar2"
SWEP.CSMuzzleFlashes = true


SWEP.Primary.ConeMax		= 0.16
SWEP.Primary.ConeMin		= 0.04


SWEP.IronSightsPos = Vector(-6.361, -7.639, 2.559)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.OverridePos = Vector(-2, -3.541, 1.519)
SWEP.OverrideAng = Vector( 0,0,0 )

