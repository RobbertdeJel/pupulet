local META = FindMetaTable("Entity")
if not META then return end


function META:HitFence(data, phys)
	local pos = phys:GetPos()
	local vel = data.OurOldVelocity
	local endpos = data.HitPos + vel:GetNormalized()
	if util.TraceLine({start = pos, endpos = endpos, mask = MASK_SOLID, filter = self}).Hit and not util.TraceLine({start = pos, endpos = endpos, mask = MASK_SHOT, filter = self}).Hit then -- Essentially hit a fence or passable object.
		self:SetPos(data.HitPos)
		phys:SetPos(data.HitPos)
		phys:SetVelocityInstantaneous(vel)

		return true
	end

	return false
end

function META:IsBehind( ent )
	return ( self:GetPos() - ent:GetPos() ):Dot( ent:GetForward() ) < 0
end

function META:TraceLine ( distance, _mask, filter )
	local vStart = self:GetShootPos()
	if filter then 
		return util.TraceLine({start=vStart, endpos = vStart + self:GetAimVector() * distance, filter = self, mask = _mask, filter = filter })
	else
		return util.TraceLine({start=vStart, endpos = vStart + self:GetAimVector() * distance, filter = self, mask = _mask })
	end
end

