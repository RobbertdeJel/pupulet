include("shared.lua")
include("animations.lua")

function SWEP:OnRemove()
	self:Anim_OnRemove()
end


local function CosineInterpolation(y1, y2, mu)
	local mu2 = (1 - math.cos(mu * math.pi)) / 2
	return y1 * (1 - mu2) + y2 * mu2
end

function SWEP:OnDrop()
self:DrawModel()
print( "yes" )
end

function SWEP:ViewModelDrawn()
	self:Anim_ViewModelDrawn()
end

function SWEP:PreDrawViewModel(vm)
	if self.ShowViewModel == false then
		render.SetBlend(0)
	end
end

function SWEP:PostDrawViewModel(vm)
	if self.ShowViewModel == false then
		render.SetBlend(1)
	end
end

function SWEP:DrawWorldModel()
	local owner = self:GetOwner()
	if owner:IsValid() and owner.ShadowMan then return end

	self:Anim_DrawWorldModel()
end


local ghostlerp = 0
function SWEP:GetViewModelPosition(pos, ang)
	if self:IsSwinging() then
		local rot = self.SwingRotation
		local offset = self.SwingOffset

		ang = Angle( ang.pitch, ang.yaw, ang.roll ) -- Copies.
		
		local swingtime = self.SwingTime
		
		local swingend = self:GetSwingEnd()
		local delta = self.SwingTime - math.max(0, swingend - CurTime())
		local power = CosineInterpolation(0, 1, delta / swingtime)

		if power >= 0.8 then
			power = (1 - power) * 4
		end

		pos = pos + offset.x * power * ang:Right() + offset.y * power * ang:Forward() + offset.z * power * ang:Up()

		ang:RotateAroundAxis(ang:Right(), rot.pitch * power)
		ang:RotateAroundAxis(ang:Up(), rot.yaw * power)
		ang:RotateAroundAxis(ang:Forward(), rot.roll * power)
	end

	if ghostlerp > 0 then
		ghostlerp = math.max(0, ghostlerp - FrameTime() * 5)
	end

	if ghostlerp > 0 then
		pos = pos + 3.5 * ghostlerp * ang:Up()
		ang:RotateAroundAxis(ang:Right(), -30 * ghostlerp)
	end

	return pos, ang
end
