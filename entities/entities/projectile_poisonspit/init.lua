AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self.DeathTime = CurTime() + 30
	self.IsSticking = false
	self.ExplodeTime = 0
	
	self:SetModel("models/props/cs_italy/orange.mdl")
	self:PhysicsInitSphere( 1 )
	self:SetSolid( SOLID_VPHYSICS )
	self:SetCollisionGroup( COLLISION_GROUP_PROJECTILE )
	self:SetColor(Color(0, 255, 0, 255))
	self:SetOwner( self:GetOwner() )
	self.Team = function()
		return 4
	end
	self.PhysObj = self:GetPhysicsObject()
	if self.PhysObj:IsValid() then
		self.PhysObj:Wake()
		self.PhysObj:SetMass( 3 )
		self.PhysObj:SetMaterial( "metal" )
	end
end

function ENT:Think()
	if self.DeathTime <= CurTime() then
		self:Remove()
	end
		
end

//When it collides with something
function ENT:PhysicsCollide( Data, Phys ) 
	local HitEnt = Data.HitEntity
	self.SpitHitPos = self:GetPos()
	//Stick it more
	--local trace = util.TraceLine( { start = self:GetPos(), endpos = self:GetPos(), filter = self } )
	
	//See if it hit a human
	if IsValid( HitEnt ) and ( HitEnt:IsPlayer() ) and ( HitEnt:IsHuman() ) then
		HitEnt:EmitSound( "vo/ravenholm/monk_death07.wav", 100, math.random( 90, 110 ) )

		//Take damage
		if IsValid( self:GetOwner() ) then
			HitEnt:TakeDamage( math.random( 13, 25 ), self:GetOwner(), self:GetOwner():GetActiveWeapon() )
		end
		
		self:Remove()
		else
			if ( !HitEnt:IsPlayer() ) then
				local effectdata = EffectData()
				effectdata:SetOrigin( self.SpitHitPos )
				effectdata:SetNormal( Vector( 0, 0, 1 ) )
				util.Effect("spithit", effectdata)
				
				self:Remove()
			end
	end
end

