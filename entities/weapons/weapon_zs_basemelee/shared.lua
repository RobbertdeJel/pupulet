if SERVER then
	AddCSLuaFile("shared.lua")
	AddCSLuaFile("cl_init.lua")
	AddCSLuaFile("animations.lua")
end

SWEP.Weight	= 5
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom	= true

SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false
SWEP.CSMuzzleFlashes = false

SWEP.Author = "Rob"
SWEP.Contact = "robbertdejel@hotmail.com"
SWEP.PrintName = "Melee Weapon"
SWEP.Purpose = "Melee Weapon Base"
SWEP.Instructions = "None"

SWEP.Spawnable = true
SWEP.AdminSpawnable	= true

//Damge and delay
SWEP.Primary.Damage	= 300
SWEP.Primary.Delay = 0.3
SWEP.Primary.Distance = 65
//Nothing useful here
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true 

SWEP.MissSound = Sound( "weapons/knife/knife_slash"..math.random( 1, 2 )..".wav" )
SWEP.HitPlayerSound = Sound ( "weapons/knife/knife_hit"..math.random( 1, 2 )..".wav" )
SWEP.HitRest = Sound( "weapons/knife/knife_hitwall1.wav" )
SWEP.SwingTime = 0.5
SWEP.AttackAnim = ACT_VM_MISSCENTER
SWEP.MissAnim = ACT_VM_MISSCENTER
SWEP.SwingHoldType = "grenade"

//Deploy speed
SWEP.DeploySpeed = 0.6
SWEP.SwingRotation = Angle( 0, 0, 0 )
SWEP.SwingOffset = Vector( 0, 0, 0 )
//Default holdtype
SWEP.HoldType = "melee"




/*-------------------------------------------
       Called on weapon initialization
-------------------------------------------*/
function SWEP:Initialize()
	self:SetDeploySpeed(1.1)
	self:SetWeaponHoldType(self.HoldType)
	self:SetWeaponSwingHoldType(self.SwingHoldType)

	if CLIENT then
		self:Anim_Initialize()
	end
end

function SWEP:SetWeaponSwingHoldType(t)
	local old = self.ActivityTranslate
	self:SetWeaponHoldType(t)
	local new = self.ActivityTranslate
	self.ActivityTranslate = old
	self.ActivityTranslateSwing = new
end

/*---------------------------------------
       Is this weapon a melee
---------------------------------------*/
function SWEP:IsMelee()
	return true
end

/*------------------------------------
       Called on weapon deploy
------------------------------------*/
function SWEP:Deploy()
	//Draw animation
	self.Weapon:SendWeaponAnim ( ACT_VM_DRAW )
	
	self.Weapon:SetNextPrimaryFire ( CurTime() + self.DeploySpeed )
	
	return true
end

/*------------------------------------------------------
            Called when the weapon is equiped
-------------------------------------------------------*/

function SWEP:PlayHitSound()

	self:EmitSound( self.HitSound )

end

function SWEP:PlayMisSound()

	self:EmitSound( self.MissSound )

end


function SWEP:OtherSound()

	self:EmitSound( self.HitRest )

end

function SWEP:MeleeHitWorld(trace)
end

function SWEP:MeleeHitEntity( ent, trace, damage )
	local phys = ent:GetPhysicsObject()
	if phys:IsValid() and phys:IsMoveable() then
			phys:ApplyForceOffset( damage * 50 * trace.Normal, (ent:NearestPoint(trace.StartPos) + ent:GetPos() * 2) / 3)
	end
end


function SWEP:MeleeHitPlayer( ent, trace, damage )
		local effectdata = EffectData()
						effectdata:SetOrigin(trace.HitPos)
						effectdata:SetNormal(trace.HitNormal * -1 + VectorRand() * 0.25)
						effectdata:SetMagnitude(math.random( 500, 700 ) )
					util.Effect("meleebloodeffect", effectdata)
end


function SWEP:ApplyMeleeDamage(ent, trace, damage)
	if ent:IsPlayer() then
		if SERVER then
			ent:TakeSpecialDamage(damage, DMG_SLASH, self.Owner, self, trace.HitPos )
		end
	else
		local dmgtype, owner, hitpos = DMG_SLASH, self.Owner, trace.HitPos
		timer.Simple(0, function() -- Avoid prediction errors.
			if ent:IsValid() then
				if SERVER then
					ent:TakeSpecialDamage(damage, dmgtype, owner, self, hitpos)
				end
			end
		end)
	end
end

function SWEP:Think()

	if self:IsSwinging() and self:GetSwingEnd() <= CurTime() then
		self:StopSwinging()
		self:Swung()
	end
end

function SWEP:Swung()
	local owner = self.Owner
	owner:LagCompensation( true )
	if owner.ViewPunch then owner:ViewPunch( Angle( math.Rand( 1,3 ),math.Rand( 1,3 ), math.Rand( -1,-3  ) ) ) end
	local trace = owner:MeleeTrace( self.Primary.Distance, 1.5, owner:GetMeleeFilter(), owner:GetShootPos() )

		if trace.HitWorld then
			self:MeleeHitWorld(trace)
			self:OtherSound()
			self.Weapon:SendWeaponAnim( self.AttackAnim )

		else
			local ent = trace.Entity
				if trace.Hit then
					if IsValid( ent ) then
						if  ent:IsPlayer() then
								self:MeleeHitPlayer( ent, trace, self.Primary.Damage )
								self:ApplyMeleeDamage( ent, trace, self.Primary.Damage )
								self.Weapon:SendWeaponAnim( self.AttackAnim )
								self:PlayHitSound()
							else
								self:MeleeHitEntity( ent, trace, self.Primary.Damage )
								self:ApplyMeleeDamage( ent, trace, self.Primary.Damage )
								self.Weapon:SendWeaponAnim( self.AttackAnim )
								self:OtherSound()
							end
							end
						else
							self.Weapon:SendWeaponAnim( self.MissAnim )
							self:PlayMisSound()
						end
		end

		owner:SetAnimation( PLAYER_ATTACK1 )
		
	owner:LagCompensation(false)

end

/*--------------------------------------------------
     Called on Primary Fire Attack ( +attack )
---------------------------------------------------*/
function SWEP:PrimaryAttack()
	//Get owner
	local pl = self.Owner
	local swingtime = self.SwingTime 
	//Cooldown 
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	if self.SwingTime == 0 then
		self:Swung()
	else
		self:SetSwingEnd( CurTime() + swingtime )
	end
	
end


if CLIENT then
function SWEP:ViewModelDrawn()
	self.ViewModelFOV =self.ViewModelFOV
end
end


/*------------------------------------
          Called on pressed R
-------------------------------------*/
function SWEP:Reload()
	return false
end

/*------------------------------------
          Called on holstered
-------------------------------------*/
function SWEP:Holster()
	return true
end

function SWEP:SecondaryAttack()
	return false
end

function SWEP:StopSwinging()
	self:SetSwingEnd(0)
end

function SWEP:IsSwinging()
	return self:GetSwingEnd() > 0
end

function SWEP:SetSwingEnd(swingend)
	self:SetDTFloat(0, swingend)
end

function SWEP:GetSwingEnd()
	return self:GetDTFloat(0)
end

function SWEP:Equip ( NewOwner )
end


