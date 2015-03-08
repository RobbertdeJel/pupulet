local META = FindMetaTable( "Player" )
if (!META) then return end

local traceHull = {}
local penatratingTrace = {}
local emptyPTrace = {}

function META:TraceHull( distance, mask, size, filter, start )
	traceHull.start = start or self:GetShootPos()
	traceHull.endpos = traceHull.start + self:GetAimVector() * distance
	traceHull.filter = filter
	traceHull.mask = mask
	traceHull.mins = Vector( -size, -size, -size )
	traceHull.maxs = Vector( size, size, size )
	return util.TraceHull( traceHull )
end

function META:MeleeTrace( distance, size, filter, start )
	return self:TraceHull(distance, MASK_SOLID, size, filter, start)
end

function META:GetMeleeFilter()
	return team.GetPlayers(self:Team())
end

function META:MeleeViewPunch(damage)
	local maxpunch = (damage + 25) * 0.5
	local minpunch = -maxpunch
	self:ViewPunch(Angle(math.Rand(minpunch, maxpunch), math.Rand(minpunch, maxpunch), math.Rand(minpunch, maxpunch)))
end

function META:PenetratingMeleeTrace(distance, size, prehit, start)
	start = start or self:GetShootPos()
	emptyPTrace = {}
	penatratingTrace.start = start or self:GetShootPos()
	penatratingTrace.endpos = penatratingTrace.start + self:GetAimVector() * distance
	penatratingTrace.filter = self:GetMeleeFilter()
	penatratingTrace.mask = MASK_SOLID
	penatratingTrace.mins = Vector( -size, -size, -size )
	penatratingTrace.maxs = Vector( size, size, size )
	local onlyhitworld
	for i=1, 50 do
		local tr = util.TraceHull( penatratingTrace )

		if not tr.Hit then break end

		if tr.HitWorld then
			table.insert( emptyPTrace, tr)
			break
		end

		if onlyhitworld then break end

		local ent = tr.Entity
		if ent and ent:IsValid() then
			if not ent:IsPlayer() then
				penatratingTrace.mask = MASK_SOLID_BRUSHONLY
				onlyhitworld = true
			end

			table.insert( emptyPTrace, tr)
			table.insert( penatratingTrace.filter, ent )
		end
	end

	if prehit and (#emptyPTrace == 1 and not emptyPTrace[1].HitNonWorld and prehit.HitNonWorld or #emptyPTrace == 0 and prehit.HitNonWorld) then
		emptyPTrace[1] = prehit
	end
	return emptyPTrace
end

function META:GiveStatus( sType, fDie )
	local cur = self:GetStatus(sType)
	if cur then
		if fDie then
			cur:SetDie(fDie)
		end
		cur:SetPlayer(self, true)
		return cur
	else
		local ent = ents.Create("status_"..sType)
		if ent:IsValid() then
			ent:Spawn()
			if fDie then
				ent:SetDie(fDie)
			end
			ent:SetPlayer(self)
			return ent
		end
	end
end

function META:GetStatus(sType)
	local ent = self["status_"..sType]
	if ent and ent.Owner == self then return ent end
end

function META:GetZombieClass()
	if self:GetDTInt( 2 )  == 0 then self:SetDTInt( 2, 1 ) end
	self.ClassZombie = self:GetDTInt( 2 ) 
	return self.ClassZombie
end

function META:GetHumanClass()
	if self:GetDTInt( 1 )  == 0 then self:SetDTInt( 1, 2 ) end
	self.ClassHuman = self:GetDTInt( 1, classnumber )
	return self.ClassHuman
end

function META:GetSuppliesTime()
	if !self:GetDTInt( 4 ) then self:SetDTInt( 4, 0 ) end
	return self:GetDTInt( 4 )
end
 
