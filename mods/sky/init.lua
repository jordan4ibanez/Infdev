-- Sky control.

core.register_on_joinplayer(function(player, last_login)
	local cloud_settings = player:get_clouds()

	cloud_settings.height = 128

	player:set_clouds(cloud_settings)
end)
