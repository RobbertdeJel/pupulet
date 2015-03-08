//Animation function tables
GM.CalcMainActivityZombies, GM.DoAnimationEventZombies, GM.UpdateAnimations = {}, {}, {}

function GM:UpdateZombieAnimation( pl, vel, maxseqgroundspeed )
	local eye = pl:EyeAngles()
	
    // correct player angles
	pl:SetLocalAngles( eye )

	//Eye angles fix
	if CLIENT then pl:SetRenderAngles( eye ) end
	
	//Controls playback
	local len2d = vel:Length2D()
	local rate = 1.0
	
	if len2d > 0.5 then
		rate = ( ( len2d * 0.8 ) / maxseqgroundspeed )
	end
	
	rate = math.Clamp(rate, 0.8, 1.5)
	
	pl:SetPlaybackRate( rate )
end

//Normal zombie - Activity handle
GM.CalcMainActivityZombies[1] = function ( pl, vel )
	local iSeq, iIdeal = -1

	local fVelocity = vel:Length2D()
	
	//Walk animation or idle
	if fVelocity > 30 then iIdeal = ACT_HL2MP_WALK_ZOMBIE_01 else iIdeal = ACT_HL2MP_IDLE_ZOMBIE end
	if ( pl:Crouching() ) then iIdeal = ACT_HL2MP_WALK_CROUCH_ZOMBIE_01 end
	return iIdeal, iSeq
end


//Headcrab - Activity handle
GM.CalcMainActivityZombies[2] = function ( pl, vel )

	//Default zombie act
	local iSeq, iIdeal = -1

	local fVelocity = vel:Length2D()
	if fVelocity > 30 then iIdeal = ACT_RUN else iIdeal = ACT_IDLE end
	
	//Jumping 
	if not pl:OnGround() then iSeq = pl:LookupSequence ( "Drown" ) end
	
	
	return iIdeal, iSeq
end

// Headcrab - Called on events like primary attack
GM.DoAnimationEventZombies[2] = function ( pl, event, data )
	if event == PLAYERANIMEVENT_ATTACK_PRIMARY then
		pl:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_RANGE_ATTACK1 )
		return ACT_INVALID
	end
end

//Ethereal - Activity handle
GM.CalcMainActivityZombies[3] = function ( pl, vel )

	//Default zombie act
	local iSeq, iIdeal = -1

	local fVelocity = vel:Length2D()
	if fVelocity > 30 then iIdeal = ACT_WALK else iIdeal = ACT_IDLE end
	
	return iIdeal, iSeq
end

// Ethereal - Called on events like primary attack
GM.DoAnimationEventZombies[3] = function ( pl, event, data )
	if event == PLAYERANIMEVENT_ATTACK_PRIMARY then
		pl:AnimRestartGesture( GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_MELEE_ATTACK1 )
		return ACT_INVALID
	end
end

//Fast zombie - Activity handle
GM.CalcMainActivityZombies[4] = function ( pl, vel )
	local iSeq, iIdeal = -1

	local fVelocity = vel:Length2D()
	if fVelocity > 110 then   
	iIdeal = ACT_RUN
	elseif fVelocity > 30 then 
	iIdeal = ACT_WALK
	else
	iIdeal = ACT_IDLE
	end
	
	if (!pl:OnGround() ) then iIdeal = ACT_JUMP end
	return iIdeal, iSeq
end

// Fast zombie - Called on events like primary attack
GM.DoAnimationEventZombies[4] = function ( pl, event, data )
		if ( event == PLAYERANIMEVENT_CUSTOM_GESTURE ) then
		if ( data == CUSTOM_PRIMARY ) then
			pl:AnimRestartGesture( GESTURE_SLOT_CUSTOM, ACT_MELEE_ATTACK1 )
		elseif ( data == CUSTOM_SECONDARY ) then
			pl.IsRoar = true
			timer.Simple ( 2, function( pl ) if IsEntityValid ( pl ) then pl.IsRoar = false end end, pl )
			return ACT_INVALID
		end
	end
end

GM.UpdateAnimations[4] = function( pl, vel, maxseqgroundspeed )
	local wep = pl:GetActiveWeapon()
	if not wep:IsValid() or not wep.GetClimbing then return end

	if wep:GetSwinging() then
		if not pl.PlayingFZSwing then
			pl.PlayingFZSwing = true
			pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_MELEE_ATTACK1 )
		end
	elseif pl.PlayingFZSwing then
		pl.PlayingFZSwing = false
		pl:AnimResetGestureSlot(GESTURE_SLOT_ATTACK_AND_RELOAD) --pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_RANGE_FRENZY, true)
	end
end

//Poison-crab - Activity handle
GM.CalcMainActivityZombies[5] = function ( pl, vel )

	//Default zombie act
	local iSeq, iIdeal = -1

	local fVelocity = vel:Length2D()
	if fVelocity > 30 then 
		if fVelocity > 180 then iIdeal = ACT_BLACKHEADCRAB_RUN_PANIC else iIdeal = ACT_RUN end
	else 	
		iIdeal = ACT_IDLE 
	end
	//Drowning
	if not pl:OnGround() then iSeq = pl:LookupSequence ( "Drown" ) end
	
	return iIdeal, iSeq
end

//Poison-crab - Called on events like primary attack
GM.DoAnimationEventZombies[5] = function ( pl, event, data )
	if ( event == PLAYERANIMEVENT_CUSTOM_GESTURE ) then
		if ( data == CUSTOM_SECONDARY ) then
			
			//Thirdperson animation
			pl.IsSpitting = true
			
			//Get sequence and restart it
			local iSeq, iDuration = pl:LookupSequence ( "Spitattack" )
			pl:AnimRestartMainSequence()
			timer.Simple ( iDuration, function( pl ) if IsEntityValid ( pl ) then pl.IsSpitting = false end end, pl )

			return ACT_VM_SECONDARYATTACK
		end
	end
end

//Poison Zombie - Activity handle
GM.CalcMainActivityZombies[6] = function ( pl, vel )

	//Default zombie act
	local iSeq, iIdeal = -1

	local fVelocity = vel:Length2D()
	if fVelocity > 30 then iIdeal = ACT_WALK else iIdeal = ACT_IDLE end
	
	return iIdeal, iSeq
end

// Poison Zombie - Called on events like primary attack
GM.DoAnimationEventZombies[6] = function ( pl, event, data )
	if event == PLAYERANIMEVENT_ATTACK_PRIMARY then
		pl:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_MELEE_ATTACK1, true)
		return ACT_INVALID
	end
end



//Zombine - Activity handle
GM.CalcMainActivityZombies[7] = function ( pl, vel )

	//Default zombie act
	local iSeq, iIdeal = pl:LookupSequence ( "Idle01" )
	if pl.HoldingGrenade then iSeq = pl:LookupSequence ( "Idle_Grenade" ) end
	
	local fVelocity = vel:Length2D()
	
	//Walking
	if fVelocity >= 1 then
		iSeq = pl:LookupSequence ( "walk_All" )
	
		//Walking with grenade
		if pl.HoldingGrenade then iSeq = pl:LookupSequence ( "walk_All_Grenade" ) end
	end
	
	//Sprinting
	if ( fVelocity >= 150 ) then
		iSeq = pl:LookupSequence ( "Run_All" ) 
		
		//Player running with grenade
		if pl.HoldingGrenade then iSeq = pl:LookupSequence ( "Run_All_grenade" ) end
	end
	
	//Getting grenade
	if pl.IsGettingNade then
		iSeq = pl:LookupSequence ( "pullGrenade" )
	end
	
	//Attacking animation
	if pl.IsAttacking then iSeq = pl:LookupSequence ( pl.AttackSequence ) end
		
	return iIdeal, iSeq
end

// Zombine - Called on events like primary attack
local Attacks = { "attackD", "attackE", "attackF", "attackB" }
GM.DoAnimationEventZombies[7] = function ( pl, event, data )

	//Weapon deploy
	if ( event == 34 ) then
		
		//Set up the vars
		pl.HoldingGrenade, pl.IsAttacking, pl.IsGettingNade = false, false, false
		
		return ACT_INVALID
	end
	
	//Now custom gestures
	if ( event == PLAYERANIMEVENT_CUSTOM_GESTURE ) then
	
		//Attacking
		if ( data == CUSTOM_PRIMARY ) then
		
			//Animation status
			pl.IsAttacking = true
			pl.AttackSequence = table.Random ( Attacks )
			
			//Get sequence and restart it
			pl:AnimRestartMainSequence()
			timer.Simple ( 1.2, function( pl ) if IsEntityValid ( pl ) then pl.IsAttacking = false end end, pl )
			
			return ACT_VM_PRIMARYATTACK
		end
		
		//Getting grenade
		if ( data == CUSTOM_SECONDARY ) then
		
			//Getting grenade
			pl.IsGettingNade = true
			pl:AnimRestartMainSequence()
			timer.Simple ( 1, function( pl ) if IsEntityValid ( pl ) then pl.IsGettingNade = false pl.HoldingGrenade = true end end, pl )
						
			return ACT_VM_SECONDARYATTACK
		end
	end
end
