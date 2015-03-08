if SERVER then
        AddCSLuaFile("shared.lua")
end
 
if CLIENT then
        SWEP.PrintName = "hl2 Pistol"
        SWEP.Author = "Rob"
        SWEP.Slot = 1
        SWEP.SlotPos = 1
        SWEP.ViewModelFlip = false
        SWEP.ViewModelFOV = 50
       	SWEP.killFont = "weaponSelectionFont_HL2_Big"
		SWEP.WeaponSlot = 2
		SWEP.IconLetter = "-"
	    killicon.AddFont( "weapon_zs_classic_pistol", "HL2MPTypeDeath", SWEP.IconLetter, Color(255, 255, 255, 255 ) )
end
 
SWEP.Base				= "weapon_zs_base"
 
SWEP.Spawnable                  = true
SWEP.AdminSpawnable             = true


SWEP.UseHands = true

SWEP.ViewModel = Model( "models/weapons/c_pistol.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_pistol.mdl" )
 
SWEP.Weight                             = 5
 
SWEP.HoldType = "pistol"
 
SWEP.Primary.Sound                      = Sound( "Weapon_Pistol.NPC_Single" )
SWEP.Primary.Recoil                     = 3
SWEP.Primary.Damage                     = 13
SWEP.Primary.NumShots          			= 2
SWEP.Primary.ClipSize          			= 12
SWEP.Primary.Delay                      = 0.2
SWEP.Primary.DefaultClip        		= 55
SWEP.MaxAmmo                        	= 160
SWEP.Primary.Automatic          		= false
SWEP.Primary.Ammo                       = "pistol"
SWEP.Primary.ConeMax		= 0.12
SWEP.Primary.ConeMin		= 0.035
 

 
SWEP.IronSightsPos = Vector( -5.8, -1.951, 2.68 )
SWEP.IronSightsAng = Vector( 0, -1, 0 )