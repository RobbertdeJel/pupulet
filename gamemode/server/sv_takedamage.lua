include( "sv_classes.lua" )
include( "obj_player.exstended.lua" )
--[----------------------------------------------------------------------
--This is where all the magic happens, I hate to move it to a separate file to keep things clean.
--I hate doing stuff like this too, but i had to.

--]----------------------------------------------------------------------

//I moved this to a separate lua file because it's massive... 
function GM:EntityTakeDamage( target, dmginfo, hitgroup )

end	

hook.Add( "EntityTakeDamage", "PainSounds", function( target, dmginfo )
		if ( target:IsPlayer() && target:Team() == 4 && IsValid( target ) && HumanClasses[ target:GetHumanClass() ].painSounds  ) then
				HumanClasses[ target:GetHumanClass() ].painSounds( target )
		end
		
		if ( target:IsPlayer() && target:Team() == 3 && IsValid( target ) && ZombieClasses[ target:GetZombieClass() ].PainSound ) then
			ZombiePainSounds = ZombieClasses[ target:GetZombieClass() ].PainSound( target )		
		end
			
end )

hook.Add( "EntityTakeDamage", "ClassDrawBacks", function( target, damageInfo )
	if ( IsValid( target ) && target:IsPlayer()  && damageInfo:GetAttacker( ):IsPlayer() && target:Team() == 4 ) then
		HumanClasses[ target:GetHumanClass() ].damageRecFunc( target, damageInfo )	
	end
end )

hook.Add( "EntityTakeDamage", "ClassPerks", function( target, damageInfo )
	if ( IsValid( target ) && damageInfo:GetAttacker( ):IsPlayer() && target:IsPlayer() && target:Team() == 3 ) then
		if ( damageInfo:GetAttacker( ).GetActiveWeapon && damageInfo:GetAttacker( ):GetActiveWeapon().GetClass ) then
			local wep = damageInfo:GetAttacker( ):GetActiveWeapon():GetClass()
			HumanClasses[ damageInfo:GetAttacker( ):GetHumanClass() ].damageBonusFunc( target, damageInfo, wep )
		end
	end			
end )

//TeamKilling no more.
function GM:PlayerShouldTakeDamage( victim, attacker )
	if ( victim:IsValid() and attacker:IsValid() and victim:IsPlayer() and attacker:IsPlayer() and attacker != victim ) then
		if ( victim:Team() == attacker:Team() ) then
			return false
		end
	end
	return true 
 end

//YO BREAK YA FUCKING LEGS M8.
function GM:GetFallDamage( pl, speed )
	if ( pl:Team() == 4 and speed >= 480 ) then
		return ( speed / 30 )
	else 
		return 0
	end
 
end

//Leave the pigeons alone :<
function GM:OnNPCKilled()
return false						
end

function GM:ScalePlayerDamage( pl, hitgroup, damageInfo )
	// if ( hitgroup == HITGROUP_HEAD ) then
		//damageInfo:ScaleDamage( HumanClasses[ pl:GetHumanClass() ].classHeadShotMultiplier )
	// end
	 
	 if ( IsValid( pl ) && pl:IsPlayer()  && damageInfo:GetAttacker( ):IsPlayer() && pl:Team() == 3 && damageInfo:GetAttacker( ):Team() == 4 ) then
		ZombieClasses[ pl:GetZombieClass() ].takeDamageFunc( pl, hitgroup, damageInfo )	
	end	

end
