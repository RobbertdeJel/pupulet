if SERVER then
	AddCSLuaFile("shared.lua")
end

SWEP.HoldType = "shotgun"

if CLIENT then
	SWEP.PrintName = "M1014"			
	SWEP.Author	= "Rob"
	SWEP.SlotPos = 4
	SWEP.ViewModelFlip = false
	SWEP.ViewModelFOV = 55
	SWEP.IconLetter = "B"
	SWEP.killFont = "weaponSelectionFont_CSS_Big"
	SWEP.WeaponSlot = 1
	SWEP.Slot = 0
	killicon.AddFont("weapon_zs_m1014", "CSKillIcons", SWEP.IconLetter, Color(255, 255, 255, 255 ))
end
SWEP.HoldType = "shotgun"
SWEP.Base				= "weapon_zs_base_shotgun"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/cstrike/c_shot_xm1014.mdl"
SWEP.WorldModel			= "models/weapons/w_shot_xm1014.mdl"

SWEP.Weight				= 10
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("Weapon_XM1014.Single")
SWEP.Primary.Recoil			= 8
SWEP.Primary.Damage			= 9
SWEP.Primary.NumShots		= 8
SWEP.Primary.ClipSize		= 8
SWEP.Primary.Delay			= 0.25
SWEP.Primary.DefaultClip	= SWEP.Primary.ClipSize*7
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "buckshot"
SWEP.Primary.ReloadDelay	= 1
SWEP.Primary.ConeMax		= 0.15
SWEP.Primary.ConeMin		= 0.10

SWEP.CSMuzzleFlashes = true


SWEP.IronSightsPos = Vector( -2.16, -5, 1.55)
SWEP.IronSightsAng = Vector(0.001,.75,0.001)

