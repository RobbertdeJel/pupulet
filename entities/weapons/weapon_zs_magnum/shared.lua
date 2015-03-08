-- © Limetric Studios ( www.limetricstudios.com ) -- All rights reserved.
-- See LICENSE.txt for license information

if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Magnum"
	SWEP.Author	= "Rob"
	SWEP.Slot = 1
	SWEP.SlotPos = 1
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 50
	SWEP.killFont = "weaponSelectionFont_HL2"
	SWEP.WeaponSlot = 2
	SWEP.IconLetter = "."
	killicon.AddFont( "weapon_zs_magnum", "HL2MPTypeDeath", SWEP.IconLetter,Color(255, 255, 255, 255 ) )
end

SWEP.Base				= "weapon_zs_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.UseHands = true
SWEP.HoldType = "revolver"

SWEP.ViewModel			= Model ( "models/weapons/c_357.mdl" )
SWEP.WorldModel			= Model ( "models/weapons/w_357.mdl" )

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "pistol"

SWEP.Primary.Sound			= Sound( "Weapon_357.Single" )
SWEP.Primary.Recoil			= 6
SWEP.Primary.Damage			= 51
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 6
SWEP.Primary.Delay			= 0.55
SWEP.Primary.DefaultClip	= SWEP.Primary.ClipSize * 5
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"--?
SWEP.WalkSpeed = 200
SWEP.MaxAmmo			    = 60

SWEP.Primary.ConeMax		= 0.13
SWEP.Primary.ConeMin		= 0.038

SWEP.IronSightsPos = Vector(-4.64, -5.056, 1)
SWEP.IronSightsAng = Vector(-2, 0, 0)

SWEP.OverridePos = Vector(-1.481, -6.394, 1.559)
SWEP.OverrideAng = Vector( 0,0,0 )



