if SERVER then AddCSLuaFile( "shared.lua" ) end

//Melee base
SWEP.Base = "weapon_zs_basemelee"

//Models paths
SWEP.Author = "Rob"
SWEP.ViewModel = "models/weapons/cstrike/c_knife_t.mdl" 
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"  

//Name and fov
SWEP.PrintName = "Combat Knife"

//Position
SWEP.Slot = 2
SWEP.SlotPos = 6

//Damage, distane, delay
SWEP.Primary.Damage = 20
SWEP.Primary.Delay = 0.6
SWEP.Primary.Distance = 45
SWEP.UseHands			= true
SWEP.HitSound = Sound ( "weapons/knife/knife_hit"..math.random( 1, 4 )..".wav" )
SWEP.MissSound = Sound( "weapons/knife/knife_slash"..math.random( 1, 2 )..".wav" )
SWEP.HitRest = Sound( "weapons/knife/knife_hitwall1.wav" )
SWEP.SwingTime = 0.15
SWEP.AttackAnim = ACT_VM_MISSCENTER
SWEP.MissAnim = ACT_VM_MISSCENTER
SWEP.HoldType = "knife"

//Killicon
if CLIENT then 
	SWEP.Slot = 2
	SWEP.ViewModelFOV = 57
	SWEP.SlotPos = 1
	
	
	SWEP.killFont = "weaponSelectionFont_CSS"
	SWEP.WeaponSlot = 3
	SWEP.IconLetter = "j"
	killicon.AddFont( "weapon_zs_melee_combatknife", "CSKillIcons", SWEP.IconLetter, Color(255, 80, 0, 255 ) ) 
end

function SWEP:Precache()
	util.PrecacheSound("weapons/knife/knife_slash1.wav")
	util.PrecacheSound("weapons/knife/knife_slash2.wav")
end




--self.HitSound = Sound( "weapons/knife/knife_slash"..i..".wav" )

 