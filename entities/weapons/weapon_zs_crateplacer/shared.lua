
if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

SWEP.HoldType = "Pistol"

if ( CLIENT ) then
	SWEP.PrintName = "Crate placer"
	SWEP.Slot = 4
	SWEP.SlotPos = 1
	SWEP.DrawCrosshair = false
	SWEP.ViewModelFlip = false
	
	
end

SWEP.Author = "Rob"

SWEP.ViewModel = "models/weapons/v_toolgun.mdl"
SWEP.WorldModel	= "models/weapons/w_toolgun.mdl"

SWEP.Table = {}
SWEP.Table[ game.GetMap() ] = {}
SWEP.Angles = 0
SWEP.Slot = 5
SWEP.SlotPos = 1 


SWEP.Primary.ClipSize =-1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "SniperRound"
SWEP.Primary.Delay = 2.0

SWEP.Secondary.ClipSize = 1
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "CombineCannon"
SWEP.Secondary.Delay = 0.15

SWEP.ReloadDelay = 0
SWEP.PrintDelay = 4

function SWEP:Precache()
	
	util.PrecacheSound("npc/roller/blade_cut.wav")
	
	util.PrecacheModel( self.ViewModel )
end

function SWEP:Deploy()

	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
end

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire ( CurTime() + 0.65 )
	
if SERVER then
	local aimvec = self.Owner:GetAimVector()
	local shootpos = self.Owner:GetShootPos()
	
	local tr = util.TraceLine({start = shootpos, endpos = shootpos + aimvec * 500, filter = self.Owner})
		
	
	local angles = aimvec:Angle()	
	local ent = ents.Create ("item_supplycrate")
		if (IsValid(ent)) then
			table.insert( self.Table[ game.GetMap() ], tr.HitPos  )
			ent:SetPos( tr.HitPos )
			ent:SetAngles( Angle (0,self.Angles,0 ) )
			--ent:SetNWEntity("TurretOwner",self.Owner)
			ent:Spawn()
			ent:Activate()
			ent:EmitSound("npc/roller/blade_cut.wav")
		end
end
	
end
	
function SWEP:Reload() 
local aimvec = self.Owner:GetAimVector()
local shootpos = self.Owner:GetShootPos()
local tr = util.TraceLine({start = shootpos, endpos = shootpos + aimvec * 500, filter = self.Owner})
if self.ReloadDelay < CurTime() then
	self.ReloadDelay = CurTime() + 2
	if SERVER then

		if tr.Entity:GetClass() != NULL and tr.Entity:GetClass() == "item_supplycrate" then	
			tr.Entity:Remove()
			self.Owner:ChatPrint( "Removed all crates and cleaned table!" )
		end
		table.Empty( self.Table[ game.GetMap() ] )
	end
end
	return false
end  
 
function SWEP:SecondaryAttack()

	self:SetNextSecondaryFire(CurTime() + 0.1)
	
	if SERVER then
		self.Angles = self.Angles + 20
		print( self.Angles )
	elseif CLIENT then
		surface.PlaySound("npc/headcrab_poison/ph_step4.wav")
	end
	
end 


function SWEP:Think()
if ( self.PrintDelay < CurTime() and self.Owner:KeyDown( IN_USE ) ) then
	self.PrintDelay = CurTime() + 4
	if SERVER then
		self.Owner:ChatPrint( "Printed table to console!" )
		PrintTable( self.Table )
	end	
end	


	if SERVER then
		local owner = self.Owner
		local effectdata = EffectData()
		effectdata:SetEntity( owner )
		effectdata:SetOrigin( owner:GetShootPos() + owner:GetAimVector() * 500 )
		effectdata:SetNormal( owner:GetAimVector() )
		util.Effect("ghost_crate", effectdata, nil, true)
		
	end

end

