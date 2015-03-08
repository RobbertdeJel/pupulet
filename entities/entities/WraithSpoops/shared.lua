AddCSLuaFile("shared.lua")

ENT.Type 			= "anim"
ENT.PrintName		= ""
ENT.Author			= "Rob"
ENT.Purpose			= ""

ENT.Spawnable			= false
ENT.AdminSpawnable		= false


function ENT:Initialize()
	if CLIENT then
	self.emitter = ParticleEmitter( self.Entity:GetPos() )
	end
	

end	


function ENT:Think()	
	local pos = self:GetPos()

	local up = Vector( 0, 0, 52 )
	self.PThinkTimer = self.PThinkTimer 
	if ( self.PThinkTimer == nil ) then self.PThinkTimer = CurTime() + 0.3 end
		if( self.PThinkTimer < CurTime() ) then
	for x=1, math.Rand( 12, 63 ) do
	if self.emitter then
		local particle2 = self.emitter:Add("particles/smokey", pos + up )
		particle2:SetVelocity(Vector( math.Rand(-82, 82), math.Rand(-62, 62),  math.Rand(-62, 62) ))
		particle2:SetColor( 40, 40, 40 )
		particle2:SetDieTime(math.Rand( 0.7 , 1.2 ))
		particle2:SetStartAlpha( math.Rand( 70, 120 ) )
		particle2:SetEndAlpha( 0 )
		particle2:SetStartSize( 9 )
		particle2:SetEndSize( 16 )
		particle2:SetRoll( 30 )
		particle2:SetRollDelta(math.Rand(-1, 1))
	end
	self.PThinkTimer = CurTime() + math.Rand( 0.1, 0.4 )
	end
	end
end


function ENT:SpawnParticleEffect()
	for x=1, 1 do
		local vecRan = VectorRand():GetNormalized()
		vecRan = vecRan * math.Rand( 34, 40 )
		vecRan.z = math.Rand( -48, -62 )
	
		local particle = self.emitter:Add("particle/particle_glow_05", pos + up + vecRan )
		particle:SetColor ( 0, 180, 0 )
		particle:SetVelocity( Vector(0, 0, 30 ) )
        particle:SetDieTime( 1.5 )
		particle:SetStartAlpha( 140 ) 
		particle:SetEndAlpha( 10 )
        particle:SetStartSize( 15 )
        particle:SetEndSize( 35 )
	end
end

function ENT:Draw()
end

function ENT:OnRemove()

end


