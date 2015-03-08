include('shared.lua')

util.PrecacheSound("npc/scanner/combat_scan2.wav")


function ENT:Initialize()
	self:SetRenderMode(RENDERMODE_TRANSALPHA)
	local tab = { "FFFF-", "SHI-", "NOO-", "LOL", "ROFL", "LMAO"  }
	self.DispText = tab[math.random(1,#tab)]
	
	self.DrawText = false
	
	timer.Simple(4,function()
		if IsValid( self ) then
			self.DrawText = true
			self:EmitSound("npc/scanner/combat_scan2.wav")
		end
	end)
end

function ENT:Draw()
	self.Entity:DrawModel()
	local FixAngles = self.Entity:GetAngles()
	local FixRotation = Vector(0, 270, 0)

	FixAngles:RotateAroundAxis(FixAngles:Right(), 	FixRotation.x)
	FixAngles:RotateAroundAxis(FixAngles:Up(), 		FixRotation.y)
	FixAngles:RotateAroundAxis(FixAngles:Forward(), FixRotation.z)
	local TargetPos = self.Entity:GetPos() + (self.Entity:GetUp() * 9)
	if self.DrawText then
		cam.Start3D2D(TargetPos, FixAngles, 0.15)
		draw.SimpleText(self.DispText, "default", 25, -20, Color(255,0,0,255),1,1)
		cam.End3D2D() 
	end
end

function ENT:Think()

end
