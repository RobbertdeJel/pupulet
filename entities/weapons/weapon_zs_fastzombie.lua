AddCSLuaFile()

SWEP.Base = "weapon_zs_zombie"

SWEP.ViewModel = Model("models/weapons/v_fza.mdl")
SWEP.WorldModel = Model("models/weapons/w_crowbar.mdl")

if CLIENT then
	SWEP.ViewModelFOV = 70
end

SWEP.MeleeDelay = 0
SWEP.MeleeReach = 42
SWEP.MeleeDamage = 5
SWEP.MeleeForceScale = 0.1
SWEP.MeleeSize = 1.5
SWEP.MeleeDamageType = DMG_SLASH
SWEP.Primary.Delay = 0.32

SWEP.PounceDamage = 3
SWEP.PounceDamageType = DMG_IMPACT
SWEP.PounceReach = 32
SWEP.PounceSize = 16
SWEP.PounceStartDelay = 0.5
SWEP.PounceDelay = 1.25
SWEP.PounceVelocity = 700

SWEP.RoarTime = 1.6
SWEP.AttackAmmo = 7
SWEP.Secondary.Automatic = true
SWEP.AttackingAnimation = 0

SWEP.NextClimbSound = 0
SWEP.NextAllowPounce = 0
function SWEP:Think()
	self.BaseClass.Think(self)

	local curtime = CurTime()
	local owner = self.Owner

	if self:GetSwinging() then
		if not owner:KeyDown(IN_ATTACK) and self.SwingStop and self.SwingStop <= curtime then
			self:SetSwinging(false)
			self.SwingStop = nil

			self.RoarCheck = curtime + 0.1

			self:StopSwingingSound()
		end
	elseif self.RoarCheck then
		if self.RoarCheck <= curtime then
			self.RoarCheck = nil

			if owner:GetVelocity():Length2D() <= 0.5 and owner:IsOnGround() then
				self:SetRoarEndTime(curtime + self.RoarTime)
			end
		end
	elseif self:GetPouncing() then
		if owner:IsOnGround() or owner:WaterLevel() >= 2 then
			self:StopPounce()
		else
			owner:LagCompensation(true)

			local hit = false
			local traces = owner:PenetratingMeleeTrace(self.PounceReach, self.PounceSize, nil, owner:LocalToWorld(owner:OBBCenter()))
			local damage = self:GetDamage(self:GetTracesNumPlayers(traces), self.PounceDamage)

			for _, trace in ipairs(traces) do
				if not trace.Hit then continue end

				hit = true

				if trace.HitWorld then
					self:MeleeHitWorld(trace)
				else
					local ent = trace.Entity
					if ent and ent:IsValid() then
						self:MeleeHit(ent, trace, damage, 10)
					end
				end
			end

			if SERVER and hit then
				owner:EmitSound("physics/flesh/flesh_strider_impact_bullet1.wav")
				owner:EmitSound("npc/fast_zombie/wake1.wav")
			end

			owner:LagCompensation(false)

			if hit then
				self:StopPounce()
			end
		end
	elseif self:GetPounceTime() > 0 and curtime >= self:GetPounceTime() then
		self:StartPounce()
	end
		if (  CurTime() > self.NextWalk ) then
			GAMEMODE:SetPlayerSpeed( self.Owner, 260,260 )
			self.Owner:SetJumpPower( 260 )
		end
	self:NextThink(curtime)
	return true
end

function SWEP:MeleeHitEntity(ent, trace, damage, forcescale)
	self.BaseClass.MeleeHitEntity(self, ent, trace, damage, forcescale ~= nil and forcescale * 0.25)
end

function SWEP:Swung()
	self.SwingStop = CurTime() + 0.5

	if not self:GetSwinging() then
		self:SetSwinging(true)

		self:StartSwingingSound()
	end

	self.BaseClass.Swung(self)
end

function SWEP:PrimaryAttack()
	if self:IsPouncing() or self:GetPounceTime() > 0 or not self.Owner:OnGround() and not self:IsClimbing() and self.Owner:WaterLevel() < 2 
	then return end
	self.BaseClass.PrimaryAttack(self)
	GAMEMODE:SetPlayerSpeed( self.Owner, 80,80 )
	self.NextWalk = CurTime() + 0.3

end

local climbtrace = {mask = MASK_SOLID_BRUSHONLY, mins = Vector(-4, -4, -4), maxs = Vector(4, 4, 4)}
function SWEP:GetClimbSurface()
	local owner = self.Owner
	climbtrace.start = owner:GetPos() + owner:GetUp() * 12
	climbtrace.endpos = climbtrace.start + owner:GetAimVector() * 14
	local tr = util.TraceHull(climbtrace)
	if tr.Hit and not tr.HitSky then
		return tr
	end
end
SWEP.NextClimb = 0
SWEP.NextWalk = 0
function SWEP:SecondaryAttack()
	if self:IsPouncing() or self:GetPounceTime() > 0 or self.AttackAmmo == 0 then return end

	if self.Owner:IsOnGround() then
		if CurTime() < self:GetNextPrimaryFire() or CurTime() < self:GetNextSecondaryFire() or CurTime() < self.NextAllowPounce then return end
		GAMEMODE:SetPlayerSpeed( self.Owner, 1,1 )
		self.Owner:SetJumpPower( 0 )
		self.Owner:SetLocalVelocity ( Vector ( 0,0,0 ) )
		self.NextWalk = CurTime() + 1.2
		
		self:SetNextPrimaryFire(math.huge)
		self:SetPounceTime(CurTime() + self.PounceStartDelay)

		if SERVER then
			self.Owner:EmitSound("npc/fast_zombie/leap1.wav")
		end
	end
		if self:GetClimbSurface() then
			if self.NextClimb < CurTime() then
			self.Owner:SetLocalVelocity(Vector(0,0,220))
			self.Owner:DoAnimationEvent( ACT_RUN )
			self.NextClimb = CurTime() + 0.32
			self.Owner:EmitSound("player/footsteps/metalgrate"..math.random(1,4)..".wav")
			self.Weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
			end
		end
end

function SWEP:StartPounce()
	if self:IsPouncing() then return end

	self:SetPounceTime(0)

	local owner = self.Owner
	if owner:IsOnGround() then
		self:SetPouncing(true)

		self.m_ViewAngles = owner:EyeAngles()

		if SERVER then
			owner:EmitSound("NPC_FastZombie.Scream")
		end

		local dir = owner:GetAimVector()
		dir.z = math.max(0.25, dir.z)
		dir:Normalize()

		owner:SetGroundEntity(NULL)
		owner:SetVelocity((1.3) * self.PounceVelocity * dir)
		owner:SetAnimation(PLAYER_JUMP)
	end
end

function SWEP:StopPounce()
	if not self:IsPouncing() then return end

	self:SetPouncing(false)
	self:SetNextSecondaryFire(CurTime())
	self.m_ViewAngles = nil
	self.NextAllowPounce = CurTime() + self.PounceDelay
	self:SetNextPrimaryFire(CurTime() + 0.1)
end

function SWEP:Reload()
	self.BaseClass.SecondaryAttack(self)
end

function SWEP:OnRemove()
	self.Removing = true

	local owner = self.Owner
	if owner and owner:IsValid() then
		self:StopSwingingSound()
	end

	self.BaseClass.OnRemove(self)
end

function SWEP:Holster()
	local owner = self.Owner
	if owner and owner:IsValid() then
		self:StopSwingingSound()
	end

	self.BaseClass.Holster(self)
end

function SWEP:StartMoaning()
end

function SWEP:StopMoaning()
end

function SWEP:StartMoaningSound()
end

function SWEP:PlayHitSound()
	self.Owner:EmitSound("NPC_FastZombie.AttackHit")
end

function SWEP:PlayMissSound()
	self.Owner:EmitSound("NPC_FastZombie.AttackMiss")
end

function SWEP:PlayAttackSound()
end

function SWEP:PlayIdleSound()
	self.Owner:EmitSound("NPC_FastZombie.AlertFar")
	self:SetRoarEndTime(CurTime() + self.RoarTime)
end

function SWEP:PlayAlertSound()
	self.Owner:EmitSound("NPC_FastZombie.Frenzy")
	self:SetRoarEndTime(CurTime() + self.RoarTime)
end

function SWEP:StartSwingingSound()
	self.Owner:EmitSound("NPC_FastZombie.Gurgle")
end

function SWEP:StopSwingingSound()
	self.Owner:StopSound("NPC_FastZombie.Gurgle")
end

function SWEP:IsMoaning()
	return false
end


function SWEP:SetRoarEndTime(time)
	self:SetDTFloat(1, time)
end

function SWEP:GetRoarEndTime()
	return self:GetDTFloat(1)
end

function SWEP:IsRoaring()
	return CurTime() < self:GetRoarEndTime()
end

function SWEP:SetPounceTime(time)
	self:SetDTFloat(2, time)
end

function SWEP:GetPounceTime()
	return self:GetDTFloat(2)
end

function SWEP:SetPounceTime(time)
	self:SetDTFloat(2, time)
end

function SWEP:GetPounceTime()
	return self:GetDTFloat(2)
end

function SWEP:SetClimbing(climbing)
	self:SetDTBool(1, climbing)
end

function SWEP:GetClimbing()
	return self:GetDTBool(1)
end
SWEP.IsClimbing = SWEP.GetClimbing

function SWEP:SetSwinging(swinging)
	self:SetDTBool(2, swinging)
end

function SWEP:GetSwinging()
	return self:GetDTBool(2)
end

function SWEP:SetPouncing(leaping)
	self:SetDTBool(3, leaping)
end

function SWEP:GetPouncing()
	return self:GetDTBool(3)
end
SWEP.IsPouncing = SWEP.GetPouncing

if CLIENT then return end

function SWEP:Deploy()

	return self.BaseClass.Deploy(self)
end

