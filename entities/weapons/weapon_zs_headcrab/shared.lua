SWEP.ZombieOnly = true
SWEP.IsMelee = true

SWEP.ViewModel = Model ( "models/weapons/v_crowbar.mdl" )
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 0.4

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.Delay = 0.22
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo	= "none"

SWEP.PounceDamage = 7
SWEP.PounceDamageType = DMG_SLASH

SWEP.NoHitRecovery = 0.75
SWEP.HitRecovery = 1

function SWEP:Initialize()
end

function SWEP:Deploy()
	if SERVER then 
		self.Owner:DrawViewModel( false )
		self.Owner:DrawWorldModel( false )
	end
end

function SWEP:Think()
	local curtime = CurTime()
	local owner = self.Owner

	if self:GetPouncing() then
		if owner:IsOnGround() or 1 < owner:WaterLevel() then
			self:SetPouncing(false)
			self:SetNextPrimaryFire(curtime + self.NoHitRecovery)
		else
			owner:LagCompensation(true)

			local shootpos = owner:GetShootPos() - Vector( 0, 0, 60 )
			local trace = util.TraceHull({start = shootpos, endpos = shootpos + owner:GetForward() * 8, mins = owner:OBBMins() * 0.8, maxs = owner:OBBMaxs() * 0.8, filter = owner:GetMeleeFilter()})
			local ent = trace.Entity

			if trace.Hit then
				self:SetPouncing(false)
				self:SetNextPrimaryFire(curtime + self.HitRecovery)
			end

			if ent:IsValid() then
				self:SetPouncing(false)

				if SERVER then
					self:EmitBiteSound()
				end

				local damage = self.PounceDamage

				local phys = ent:GetPhysicsObject()
				if ent:IsPlayer() then
					ent:MeleeViewPunch(damage)

				elseif phys:IsValid() and phys:IsMoveable() then
					phys:ApplyForceOffset(damage * 600 * owner:EyeAngles():Forward(), (ent:NearestPoint(shootpos) + ent:GetPos() * 2) / 3)
					ent:SetPhysicsAttacker(owner)
				end
			if SERVER then
				ent:TakeSpecialDamage( damage, self.PounceDamageType, owner, self, trace.HitPos )
			end

				owner:ViewPunch(Angle(math.Rand(-20, 20), math.Rand(-20, 20), math.Rand(-20, 20)))
			elseif trace.HitWorld then
				if SERVER then
					self:EmitHitSound()
				end
			end

			owner:LagCompensation(false)
		end
	end

	self:NextThink(curtime)
	return true
end

function SWEP:PrimaryAttack()
	local owner = self.Owner
	if self:GetPouncing() or CurTime() < self:GetNextPrimaryFire() or not owner:IsOnGround() then return end

	local vel = owner:GetAimVector()
	vel.z = math.max(0.45, vel.z)
	vel:Normalize()

	owner:SetGroundEntity(NULL)
	owner:SetLocalVelocity(vel * 450)

	if SERVER then
		self:EmitAttackSound()
	end

	self.m_ViewAngles = owner:EyeAngles()

	self:SetPouncing(true)
end

function SWEP:SecondaryAttack()
	if CurTime() < self:GetNextSecondaryFire() then return end
	self:SetNextSecondaryFire(CurTime() + 2)

	if SERVER then
		self:EmitIdleSound()
	end
end

function SWEP:Reload()
return false
end

function SWEP:Move(mv)
	if self:IsPouncing() then
		mv:SetSideSpeed(0)
		mv:SetForwardSpeed(0)
	end
end

function SWEP:EmitHitSound()
	self.Owner:EmitSound("npc/headcrab_poison/ph_wallhit"..math.random(1, 2)..".wav")
end

function SWEP:EmitBiteSound()
	self.Owner:EmitSound("NPC_HeadCrab.Bite")
end

function SWEP:EmitIdleSound()
	local ent = self.Owner:MeleeTrace(4096, 24, self.Owner:GetMeleeFilter()).Entity
	if ent:IsValid() and ent:IsPlayer() then
		self.Owner:EmitSound("NPC_HeadCrab.Alert")
	else
		self.Owner:EmitSound("NPC_HeadCrab.Idle")
	end
end

function SWEP:EmitAttackSound()
	self.Owner:EmitSound("NPC_HeadCrab.Attack")
end

function SWEP:SetPouncing(pouncing)
	if not pouncing then
		self.m_ViewAngles = nil
	end

	self:SetDTBool(1, pouncing)
end

function SWEP:GetPouncing()
	return self:GetDTBool(1)
end
SWEP.IsPouncing = SWEP.GetPouncing

