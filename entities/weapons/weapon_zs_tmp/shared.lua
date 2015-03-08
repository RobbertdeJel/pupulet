-- © Limetric Studios ( www.limetricstudios.com ) -- All rights reserved.
-- See LICENSE.txt for license information

if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "TMP"			
	SWEP.Author	= "Rob"
	SWEP.Slot = 0
	SWEP.SlotPos = 1
	SWEP.ViewModelFOV = 65
	SWEP.SlotPos = 19
	SWEP.killFont = "weaponSelectionFont_CSS"
	SWEP.WeaponSlot = 1
	SWEP.IconLetter = "d"
	killicon.AddFont("weapon_zs_tmp", "CSKillIcons", SWEP.IconLetter, Color(255, 255, 255, 255 ))
end

SWEP.Base				= "weapon_zs_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= Model ( "models/weapons/cstrike/c_smg_tmp.mdl" )
SWEP.UseHands = true
SWEP.WorldModel			= Model ( "models/weapons/w_smg_tmp.mdl" )

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "smg"

SWEP.Primary.Sound			= Sound("Weapon_TMP.Single")
SWEP.Primary.Recoil			= 7
SWEP.Primary.Damage			= 15
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 25
SWEP.Primary.Delay			= 0.07
SWEP.Primary.DefaultClip	= 75
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"
SWEP.CSMuzzleFlashes = true

SWEP.Primary.ConeMax		= 0.12
SWEP.Primary.ConeMin		= 0.055

SWEP.IronSightsPos = Vector(-6.881, -12.039, 2.519)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.OverridePos = Vector(1.559, -3.116, 1.6)
SWEP.OverrideAng = Vector(0, 0, 0)


--SWEP.IronSightsPos = Vector(1.559, -3.116, 1.6)
--SWEP.IronSightsAng = Vector(0, 0, 0)