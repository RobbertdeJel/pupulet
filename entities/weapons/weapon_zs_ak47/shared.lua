-- © Limetric Studios ( www.limetricstudios.com ) -- All rights reserved.
-- See LICENSE.txt for license information

if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "ak47"
	SWEP.Author	= "Rob"
	SWEP.SlotPos = 1
	SWEP.Slot = 0
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 55
	SWEP.ShowViewModel = true
	SWEP.killFont = "weaponSelectionFont_CSS"
	SWEP.WeaponSlot = 1
	SWEP.IconLetter = "b"
	killicon.AddFont( "weapon_zs_ak47", "CSKillIcons", SWEP.IconLetter, Color(255, 255, 255, 255 ) )
end


SWEP.Base				= "weapon_zs_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= Model ( "models/weapons/cstrike/c_rif_ak47.mdl" )
SWEP.UseHands = true
SWEP.WorldModel			= Model ( "models/weapons/w_rif_ak47.mdl" )

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.PrintName			= "AK-47"

SWEP.HoldType = "ar2"

SWEP.Primary.Sound			= Sound("Weapon_AK47.Single")
SWEP.Primary.Recoil			= 2
SWEP.Primary.Damage			= 23
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 25
SWEP.storeclipsize			= 25
SWEP.Primary.Delay			= 0.15
SWEP.Primary.DefaultClip	= 220
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "ar2"
SWEP.Primary.ConeMax		= 0.18
SWEP.Primary.ConeMin		= 0.045
SWEP.CSMuzzleFlashes = true





SWEP.IronSightsPos = Vector(-6.64, -12, 2.279)
SWEP.IronSightsAng = Vector(3.03, 0, 0)

SWEP.OverridePos = Vector(3.16, -4.755, 1.639)
SWEP.OverrideAng = Vector( 0,0,0 )

