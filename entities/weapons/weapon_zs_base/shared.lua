
AddCSLuaFile( "ai_translations.lua" )
AddCSLuaFile( "sh_weaponskins.lua" )
AddCSLuaFile( "sh_anim.lua" )

include( 'sh_weaponskins.lua' )




SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false	
SWEP.PrintName			= "sp_base"	

SWEP.Author			= "Rob"
SWEP.Contact		= "robbertdejel@hotmail.com"
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false


SWEP.WeaponHoldType = "revolver"
SWEP.Primary.Sound			= Sound("Weapon_AK47.Single")
SWEP.Primary.Recoil			= 0.3
SWEP.Primary.Damage			= 40
SWEP.Primary.NumShots		= 1
SWEP.Primary.ConeMax		= 0.12
SWEP.Primary.ConeMin		= 0.05
SWEP.Primary.Delay			= 0.8

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"


SWEP.Secondary.ClipSize		= 1
SWEP.Secondary.DefaultClip	= 1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "CombineCannon"

SWEP.UseHands = true 
SWEP.IronSightsPos = Vector(0,0,0)
SWEP.IronSightsAng = Vector(0,0,0)


function SWEP:Holster( wep )
	self.ReloadingTime = 0
	return true
end

function SWEP:Precache()
end

function SWEP:Initialize()
	print( self.RemainingAmmo )
	self:SetWeaponHoldType( self.HoldType )
	//mOwner = self.Owner
	//print( self.Weapon:GetClass() )
		//if SERVER then
		//timer.Simple( 0.2, function()
			//if ( IsValid( self:GetOwner() ) and self.Owner:HasThisWeaponSkin( self.Weapon:GetClass(), 1, 1 ) ) then
					//self:SetSkinType( 4 )
					//self:SetSkinType2( 1 )
					//print( "yes" )
			//else
				//print( "no" )
			//end
		//end )
end

function SWEP:Deploy()
	self.Weapon:SendWeaponAnim( ACT_VM_DRAW ) 
	if SERVER then
		self.Owner:DrawWorldModel( true )
		self.Owner:DrawViewModel( true )
	end
	self:SetColor( Color( 255, 255, 255, 255 ) )
	self.Owner:SetColor( Color( 255, 255, 255, 255 ) )

	
	self:SetIronsights(false)
	return true
end
function SWEP:GetSkinType2()
	return self:GetDTInt( 2 )
end
function SWEP:GetSkinType()
	return self:GetDTInt( 1 )
end

function SWEP:SetSkinType( number )
	self:SetDTInt( 1, number )
end


function SWEP:SetSkinType2( number2 )
	self:SetDTInt( 2, number2 )
end

 
function SWEP:Reload()
if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end 
if ( self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then	
		self:DefaultReload( ACT_VM_RELOAD )
                local AnimationTime = self.Owner:GetViewModel():SequenceDuration()
                self.ReloadingTime = CurTime() + AnimationTime
                self:SetNextPrimaryFire(CurTime() + AnimationTime)
				self:SetNextSecondaryFire(CurTime() + AnimationTime)
				self:SetIronsights( false )
	end
end

function SWEP:Think()
	if ( self.Owner:KeyDown( IN_ATTACK2 ) and !self:SetIronsights() ) then
		self:SetIronsights( true )
	else
		self:SetIronsights( false )
	end
		
end


function SWEP:GetCones()
	if ( !self.Owner:OnGround() or self.Primary.ConeMax == self.Primary.ConeMin ) then return self.Primary.ConeMax end
	local conemax = self.Primary.ConeMax
	local conemin = self.Primary.ConeMin
	local basecone = self.Owner:GetVelocity():Length()/1000
	local multiply 
	local multimin 
	
	if ( !self.Owner:KeyDown( IN_ATTACK2 ) and !self.Owner:Crouching() ) then  multiply, multimin = 1, 1 end
	if ( self.Owner:KeyDown( IN_ATTACK2 ) ) then multiply, multimin = 0.80, 0.80 end
	if ( self.Owner:Crouching() ) then multiply, multimin = 0.70, 0.70 end
	if ( self.Owner:Crouching() and self.Owner:KeyDown( IN_ATTACK2 )  ) then multiply, multimin = 0.60, 0.60 end

		
	local ShootCone = math.Clamp( basecone, conemin * multimin, conemax * multiply )
	
	return ShootCone

end

function SWEP:PrimaryAttack()
	
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	if not self:CanPrimaryAttack() then return end -- if we can't primary attack, just in case. 

	self.Weapon:EmitSound( self.Primary.Sound )
	
	self:TakePrimaryAmmo( 1 )
	
	self:ShootBullet( self.Primary.Damage, self.Primary.NumShots, self:GetCones() )

	if CLIENT then
		self.Weapon:SetNetworkedFloat( "LastShootTime", CurTime() )
		self.Owner:ViewPunch( Angle ( math.Rand( -0.2, -0.1 ) * self.Primary.Recoil, math.Rand( -0.1 ,0.1 ) * self.Primary.Recoil, self:GetCones() ) )
		self.Owner:SetEyeAngles(  Angle( self.Owner:EyeAngles().p - ( self.Primary.Damage * self.Primary.NumShots ) / 25  , self.Owner:EyeAngles().y, self.Owner:EyeAngles().r  )  )
	end

end


function SWEP:ShootBullet( damage, num_bullets, aimcone )
 
	local bullet = {}
	bullet.Num 		= num_bullets
	bullet.Src 		= self.Owner:GetShootPos()
	bullet.Dir 		= self.Owner:GetAimVector()
	bullet.Spread 	= Vector( aimcone, aimcone, 0 )
	bullet.Tracer	= 1
        bullet.TracerName = "Tracer" 
	bullet.Force	= damage * 0.015
	bullet.Damage	= damage
 
	self.Owner:FireBullets( bullet )
 
	self:ShootEffects()
end


function SWEP:ShootEffects()
 
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	
	self.Owner:MuzzleFlash()
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
 
end


function SWEP:TakePrimaryAmmo( num )
 
	if ( self:Clip1() <= 0 ) then 
 
		if ( self:Ammo1() <= 0 ) then return end
 
		self.Owner:RemoveAmmo( num, self:GetPrimaryAmmoType() )
 
	return end
 
	self:SetClip1( self:Clip1() - num )	
 
end

function SWEP:CanPrimaryAttack()
 
	if ( self:Clip1() <= 0 ) then
 
		self:EmitSound( "Weapon_Pistol.Empty" )
		self:SetNextPrimaryFire( CurTime() + 0.2 )
		self:Reload()
		return false
 
	end
 
	return true
 
end


SWEP.NextSecondaryAttack =  2
function SWEP:SecondaryAttack()

	if ( !self.IronSightsPos ) then return end
	if ( self.NextSecondaryAttack > CurTime() ) then return end
	
	bIronsights = !self.Weapon:GetNetworkedBool( "Ironsights", false )
	
	self:SetIronsights( bIronsights )
	
	self.NextSecondaryAttack =  2
	
end

/*---------------------------------------------------------
	SetIronsights
---------------------------------------------------------*/
function SWEP:SetIronsights( b )

	self:SetDTBool( 0, b )
end
function SWEP:GetIronSights()
	return self:GetDTBool( 0 )
end


--[[---------------------------------------------------------
   Name: OnRemove
   Desc: Called just before entity is deleted
-----------------------------------------------------------]]
function SWEP:OnRemove()
end


--[[---------------------------------------------------------
   Name: OwnerChanged
   Desc: When weapon is dropped or picked up by a new player
-----------------------------------------------------------]]
function SWEP:OwnerChanged()
end


--[[---------------------------------------------------------
   Name: Ammo1
   Desc: Returns how much of ammo1 the player has
-----------------------------------------------------------]]
function SWEP:Ammo1()
	return self.Owner:GetAmmoCount( self.Weapon:GetPrimaryAmmoType() )
end


--[[---------------------------------------------------------
   Name: Ammo2
   Desc: Returns how much of ammo2 the player has
-----------------------------------------------------------]]
function SWEP:Ammo2()
	return self.Owner:GetAmmoCount( self.Weapon:GetSecondaryAmmoType() )
end

--[[---------------------------------------------------------
   Name: SetDeploySpeed
   Desc: Sets the weapon deploy speed. 
		 This value needs to match on client and server.
-----------------------------------------------------------]]
function SWEP:SetDeploySpeed( speed )
	self.m_WeaponDeploySpeed = tonumber( speed )
end

--[[---------------------------------------------------------
   Name: DoImpactEffect
   Desc: Callback so the weapon can override the impact effects it makes
		 return true to not do the default thing - which is to call UTIL_ImpactTrace in c++
-----------------------------------------------------------]]
function SWEP:DoImpactEffect( tr, nDamageType )
		
	return false;
	
end

--[[---------------------------------------------------------
   Name: SWEP:CanSecondaryAttack( )
   Desc: Helper function for checking for no ammo
-----------------------------------------------------------]]
function SWEP:CanSecondaryAttack()

	if ( self.Weapon:Clip2() <= 0 ) then
	
		self.Weapon:EmitSound( "Weapon_Pistol.Empty" )
		self.Weapon:SetNextSecondaryFire( CurTime() + 0.2 )
		return false
		
	end

	return true

end

function SWEP:TakeSecondaryAmmo( num )
	
	-- Doesn't use clips
	if ( self.Weapon:Clip2() <= 0 ) then 
	
		if ( self:Ammo2() <= 0 ) then return end
		
		self.Owner:RemoveAmmo( num, self.Weapon:GetSecondaryAmmoType() )
	
	return end
	
	self.Weapon:SetClip2( self.Weapon:Clip2() - num )	
	
end

