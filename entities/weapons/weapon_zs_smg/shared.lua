if SERVER then
	AddCSLuaFile("shared.lua")
end



if CLIENT then		
	SWEP.PrintName = "HL2-SMG"
	SWEP.Author	= "Rob"
	SWEP.Slot = 0
	SWEP.SlotPos = 1
	SWEP.ViewModelFOV = 55
	SWEP.ViewModelFlip = false
	SWEP.killFont = "weaponSelectionFont_HL2_Big"
	SWEP.WeaponSlot = 1
	SWEP.IconLetter = "/"
	killicon.AddFont("weapon_zs_smg", "HL2MPTypeDeath", SWEP.IconLetter, Color(255, 255, 255, 255 ))
end


SWEP.Base				= "weapon_zs_base"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= Model ( "models/weapons/c_smg1.mdl" )
SWEP.UseHands = true
SWEP.WorldModel			= Model ( "models/weapons/w_smg1.mdl" )

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.HoldType = "ar2"

SWEP.Primary.Sound			= Sound("Weapon_AR2.NPC_Single")
SWEP.Primary.Recoil			= 1
SWEP.Primary.Damage			= 14
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 25
SWEP.Primary.Delay			= 0.1
SWEP.Primary.DefaultClip	= 125
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"


SWEP.Primary.ConeMax		= 0.11
SWEP.Primary.ConeMin		= 0.032


SWEP.IronSightsPos 		= Vector( -6.35, -11, 1 )
SWEP.IronSightsAng 		= Vector( 0, 0, 0 )

