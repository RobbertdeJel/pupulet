local META = FindMetaTable( "Player" )
if (!META) then return end

function META:GetZombieClass()
	if self:GetDTInt( 2 )  == 0 then self:SetDTInt( 2, 1 ) end
	self.ClassZombie = self:GetDTInt( 2 ) 
	return self.ClassZombie
end

function META:GetHumanClass()
	if self:GetDTInt( 1 )  == 0 then self:SetDTInt( 1, 1 ) end
	self.ClassHuman = self:GetDTInt( 1, classnumber )
	return self.ClassHuman
end

function META:getTeamMAtesAroundMe( object )
local teamCount = 0
local ply = object
	for k, v in pairs( ply ) do 
		if  self ~= v && v:GetPos():Distance( self:GetPos() ) < 400  then
			teamCount = teamCount + 1
		end
	end
	return teamCount
end



 
