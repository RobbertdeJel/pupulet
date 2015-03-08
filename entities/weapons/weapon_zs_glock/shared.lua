if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Glock"
	SWEP.Author	= "Rob"
	SWEP.Slot = 1
	SWEP.ViewModelFOV = 50
	SWEP.SlotPos = 1
	SWEP.ViewModelFlip = false
	SWEP.killFont = "weaponSelectionFont_CSS"
	SWEP.WeaponSlot = 2
	SWEP.IconLetter = "c"
	killicon.AddFont( "weapon_zs_glock", "CSKillIcons", SWEP.IconLetter, Color(255, 255, 255, 255 ) )
end


SWEP.Base				= "weapon_zs_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= Model ( "models/weapons/cstrike/c_pist_glock18.mdl" )
SWEP.UseHands = true
SWEP.WorldModel			= Model ( "models/weapons/w_pist_glock18.mdl" )

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "pistol"

SWEP.Primary.Sound			= Sound( "Weapon_Glock.Single" )
SWEP.Primary.Recoil			= 4
SWEP.Primary.Damage			= 12
SWEP.Primary.NumShots		= 3
SWEP.Primary.ClipSize		= 7
SWEP.Primary.Delay			= 0.3
SWEP.Primary.DefaultClip	= 45
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"

SWEP.CSMuzzleFlashes = true


SWEP.Primary.ConeMax		= 0.13
SWEP.Primary.ConeMin		= 0.05


SWEP.IronSightsPos = Vector(-5.781, -10.466, 2.79)
SWEP.IronSightsAng = Vector(0.275, 0, 0)

SWEP.OverridePos = Vector(1.159, -0.913, 1.84)
SWEP.OverrideAng = Vector( 0,0,0 )

--SWEP.IronSightsPos = Vector(1.159, -0.913, 1.84)

