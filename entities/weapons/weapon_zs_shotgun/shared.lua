-- © Limetric Studios ( www.limetricstudios.com ) -- All rights reserved.
-- See LICENSE.txt for license information

if SERVER then
	AddCSLuaFile("shared.lua")
	SWEP.PrintName = "Shotgun"
end

if CLIENT then
	SWEP.PrintName = "Shotgun"			
	SWEP.Author	= "Rob"
	SWEP.Slot = 0
	SWEP.SlotPos = 17
	SWEP.ViewModelFOV = 50
	SWEP.ViewModelFlip = false
	SWEP.killFont = "weaponSelectionFont_HL2_Big"
	SWEP.WeaponSlot = 1
	SWEP.IconLetter = "0"
	killicon.AddFont( "weapon_zs_shotgun", "HL2MPTypeDeath", SWEP.IconLetter, Color( 255, 255, 255, 255 ) )
end

SWEP.Base				= "weapon_zs_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= Model ( "models/weapons/c_shotgun.mdl" )
SWEP.WorldModel			= Model ( "models/weapons/w_shotgun.mdl" )

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "shotgun"



SWEP.Primary.Sound			= Sound("Weapon_Shotgun.Single")
SWEP.Primary.Recoil			= 20
SWEP.Primary.Damage			= 24
SWEP.Primary.NumShots		= 7
SWEP.Primary.ClipSize		= 6
SWEP.Primary.Delay			= 0.5
SWEP.Primary.DefaultClip	= 12
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo	= "buckshot"

SWEP.Primary.ConeMax		= 0.16
SWEP.Primary.ConeMin		= 0.09


SWEP.IronSightsPos = Vector (-9.0313, -11.1282, 4.0295)
SWEP.IronSightsAng = Vector (0.2646, -0.0374, 0)

SWEP.OverridePos = Vector(-3.36, -9.016, 2.2)
SWEP.OverrideAng = Vector(0, 0, 0)





