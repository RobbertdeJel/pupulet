if SERVER then AddCSLuaFile( "shared.lua" ) end

//Melee base
SWEP.Base = "weapon_zs_basemelee"

//Models paths
SWEP.Author = "Deluvas"--Edited by NECROSSIN
SWEP.ViewModel = Model ( "models/weapons/c_crowbar.mdl" )
SWEP.WorldModel =  Model ( "models/weapons/w_crowbar.mdl" )

SWEP.UseHands = true
//Name and fov
SWEP.PrintName = "Crowbar"
SWEP.ViewModelFOV = 57

//Position
SWEP.Slot = 2
SWEP.SlotPos = 6

//Damage, distane, delay
SWEP.Primary.Damage = 60
SWEP.Primary.Delay = 0.8
SWEP.Primary.Distance = 45
SWEP.UseHands			= true
SWEP.HitSound = Sound ( "Weapon_Crowbar.Melee_HitWorld" )
SWEP.MissSound = Sound( "Weapon_Crowbar.Single" )
SWEP.HitRest = Sound( "Weapon_Crowbar.Melee_HitWorld" )
SWEP.SwingTime = 0.32
SWEP.SwingRotation = Angle(30, -30, -30)
SWEP.AttackAnim = ACT_VM_HITCENTER
SWEP.MissAnim = ACT_VM_MISSCENTER
SWEP.HoldType = "melee"

//Killicon
if CLIENT then 

	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.killFont = "weaponSelectionFont_HL2"
	SWEP.WeaponSlot = 3
	SWEP.IconLetter = "6"
	killicon.AddFont( "weapon_zs_crowbar", "CSKillIcons", SWEP.IconLetter, Color(255, 80, 0, 255 ) ) 

end

function SWEP:Precache()
	util.PrecacheSound("weapons/knife/knife_slash1.wav")
	util.PrecacheSound("weapons/knife/knife_slash2.wav")
end

 