




function EFFECT:Init(data)
	local ent = self.Entity
	local owner = data:GetEntity()
	local aimvec = owner:GetAimVector()
	local shootpos = owner:GetShootPos()
	local tr = util.TraceLine({start = shootpos, endpos = shootpos + aimvec * 500, filter = owner})
	
	self.Entity:SetModel("models/items/item_item_crate.mdl")

	self:SetPos(tr.HitPos)

		ent:SetColor ( Color( 255,0,0,255 ) )
	
	
	local angles = aimvec:Angle()
	self.Entity:SetAngles( Angle (0,angles.y,angles.r) )
	self.DieTime = RealTime() + 0.1
end

function EFFECT:Think()
	return RealTime() < self.DieTime
end

function EFFECT:Render()
	self.Entity:DrawModel()
end