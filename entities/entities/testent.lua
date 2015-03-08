AddCSLuaFile()

function ENT:Initialize()
	self:SetColor(Color(0, 255, 0, 255))

	self.Emitter = ParticleEmitter(self:GetPos())
	self.Emitter:SetNearClip(24, 32)
end

function ENT:Think()
	self.Emitter:SetPos(self:GetPos())
end

function ENT:OnRemove()
	--self.Emitter:Finish()
end

function ENT:Draw()
	self:DrawModel()
	if( self.IsSticking ) then print( "asdasdasd" ) end
	if CurTime() < self.NextEmit then return end
	self.NextEmit = CurTime() + 0.025

	local pos = self:GetPos()

	local particle = self.Emitter:Add("effects/fire_cloud1", pos)
	particle:SetDieTime(math.Rand(0.4, 0.5))
	particle:SetStartAlpha(255)
	particle:SetEndAlpha(0)
	particle:SetStartSize( math.Rand(3, 5) )
	particle:SetEndSize(0)
	particle:SetRoll(math.Rand(0, 255))
	particle:SetRollDelta(math.Rand(-10, 10))
	particle:SetVelocity((self:GetVelocity():GetNormalized() * -1 + VectorRand():GetNormalized()):GetNormalized() * math.Rand(16, 48))
	particle:SetColor( math.random( 10, 30 ), math.random( 70, 110 ), 30 )
end