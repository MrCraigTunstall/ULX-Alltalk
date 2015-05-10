------------------------------ alltalk ------------------------------
function ulx.alltalk( calling_ply, target_plys, should_revoke )
	if not target_plys[ 1 ]:IsValid() then
		Msg( "You are the console, you have no head to place theese ears on!.\n" )
		return
	end

	local affected_plys = {}
	for i=1, #target_plys do
		local v = target_plys[ i ]

		if ulx.getExclusive( v, calling_ply ) then
			ULib.tsayError( calling_ply, ulx.getExclusive( v, calling_ply ), true )
		else
			if should_revoke then
				v.ULXAlltalk = nil
			else
				v.ULXAlltalk = true
			end
			table.insert( affected_plys, v )
		end
	end

	if should_revoke then
		ulx.fancyLogAdmin( calling_ply, "#A disabled alltalk for #T", affected_plys )
	else
		ulx.fancyLogAdmin( calling_ply, "#A enabled alltalk for #T", affected_plys )
	end
end
local alltalk = ulx.command( "Chat", "ulx alltalk", ulx.alltalk, "!alltalk" )
alltalk:addParam{ type=ULib.cmds.PlayersArg, ULib.cmds.optional }
alltalk:addParam{ type=ULib.cmds.BoolArg, invisible=true }
alltalk:defaultAccess( ULib.ACCESS_ADMIN )
alltalk:help( "Grants/revokes almighty ears to/from target." )
alltalk:setOpposite( "ulx unalltalk", {_, _, true}, "!unalltalk" )


hook.Add("PlayerCanHearPlayersVoice", "ULXAlltalk", function( listener, speaker )
	if listener.ULXAlltalk or speaker.ULXAlltalk then 
		return true
	end
end)

