
core.register_privilege("myportal", {
	description = "Place Portals",
	give_to_singleplayer = true
})

local function parti(pos)
	core.add_particlespawner(50, 0.4,
		{x=pos.x + 0.5, y=pos.y, z=pos.z + 0.5}, {x=pos.x - 0.5, y=pos.y, z=pos.z - 0.5},
		{x=0, y=5, z=0}, {x=0, y=0, z=0},
		{x=0, y=5, z=0}, {x=0, y=0, z=0},
		3, 5,
		3, 5,
		false,
		"myportal_portal_parti.png")
end

local function parti2(pos)
	core.add_particlespawner(50, 0.4,
		{x=pos.x + 0.5, y=pos.y + 10, z=pos.z + 0.5}, {x=pos.x - 0.5, y=pos.y, z=pos.z - 0.5},
		{x=0, y=-5, z=0}, {x=0, y=0, z=0},
		{x=0, y=-5, z=0}, {x=0, y=0, z=0},
		3, 5,
		3, 5,
		false,
		"myportal_portal_parti.png")
end

core.register_node("myportal:portal_placer", {
	description = "Portal Placer",
	tiles = {
		"myportal_metal.png"
	},
	drawtype = "normal",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 2},

	on_place = function(itemstack, placer, pointed_thing)

	if core.get_player_privs(placer:get_player_name()).myportal ~= true then
		core.chat_send_player(placer:get_player_name(),
			"You need the myportal priv")
		itemstack:take_item()
		return
	end
	local pos = pointed_thing.above
	local dir = core.dir_to_facedir(placer:get_look_dir())
	local meta = core.get_meta(pos)
	local metaa = core.get_meta({x = pos.x, y = pos.y + 1, z = pos.z})
	local par = core.get_node(pos).param2
	local schem = core.get_modpath("myportal").."/schems/myportal.mts"
	local rot = 0
	local name = placer:get_player_name()
	local pos1 = pos
	local pos2 = pos
	local pos3 = pos
	local pos4 = pos
	local pos5 = pos
	local pos6 = pos
	local pos7 = pos
	local pos8 = pos

	if dir == 0 then pos1 = {x=pos.x+1,y=pos.y,z=pos.z}
						pos2 = {x=pos.x-1,y=pos.y,z=pos.z}
						pos3 = {x=pos.x,y=pos.y+1,z=pos.z}
						pos4 = {x=pos.x-1,y=pos.y+1,z=pos.z}
						pos5 = {x=pos.x+1,y=pos.y+1,z=pos.z}
						pos6 = {x=pos.x,y=pos.y+2,z=pos.z}
						pos7 = {x=pos.x+1,y=pos.y+2,z=pos.z}
						pos8 = {x=pos.x-1,y=pos.y+2,z=pos.z}
	end
	if dir == 2 then pos1 = {x=pos.x+1,y=pos.y,z=pos.z}
						pos2 = {x=pos.x-1,y=pos.y,z=pos.z}
						pos3 = {x=pos.x,y=pos.y+1,z=pos.z}
						pos4 = {x=pos.x-1,y=pos.y+1,z=pos.z}
						pos5 = {x=pos.x+1,y=pos.y+1,z=pos.z}
						pos6 = {x=pos.x,y=pos.y+2,z=pos.z}
						pos7 = {x=pos.x+1,y=pos.y+2,z=pos.z}
						pos8 = {x=pos.x-1,y=pos.y+2,z=pos.z}
	end

	if dir == 1 then pos1 = {x=pos.x,y=pos.y,z=pos.z+1}
						pos2 = {x=pos.x,y=pos.y,z=pos.z-1}
						pos3 = {x=pos.x,y=pos.y+1,z=pos.z}
						pos4 = {x=pos.x,y=pos.y+1,z=pos.z-1}
						pos5 = {x=pos.x,y=pos.y+1,z=pos.z+1}
						pos6 = {x=pos.x,y=pos.y+2,z=pos.z}
						pos7 = {x=pos.x,y=pos.y+2,z=pos.z+1}
						pos8 = {x=pos.x,y=pos.y+2,z=pos.z-1}
	end
	if dir == 3 then pos1 = {x=pos.x,y=pos.y,z=pos.z+1}
						pos2 = {x=pos.x,y=pos.y,z=pos.z-1}
						pos3 = {x=pos.x,y=pos.y+1,z=pos.z}
						pos4 = {x=pos.x,y=pos.y+1,z=pos.z-1}
						pos5 = {x=pos.x,y=pos.y+1,z=pos.z+1}
						pos6 = {x=pos.x,y=pos.y+2,z=pos.z}
						pos7 = {x=pos.x,y=pos.y+2,z=pos.z+1}
						pos8 = {x=pos.x,y=pos.y+2,z=pos.z-1}
	end

	if core.get_node(pos1).name ~= "air" or
		core.get_node(pos2).name ~= "air" or
		core.get_node(pos3).name ~= "air" or
		core.get_node(pos4).name ~= "air" or
		core.get_node(pos5).name ~= "air" or
		core.get_node(pos6).name ~= "air" or
		core.get_node(pos7).name ~= "air" or
		core.get_node(pos8).name ~= "air" then
		core.chat_send_player(name, ("There is not enough room for the portal here!"))
		return
	end

		if dir == 1 then rot = "90" pos = {x = pos.x, y = pos.y, z = pos.z - 1}
		elseif dir == 2 then rot = "0" pos = {x = pos.x - 1, y = pos.y, z = pos.z}
		elseif dir == 3 then rot = "90" pos = {x = pos.x, y = pos.y, z = pos.z - 1}
		elseif dir == 0 then rot = "0" pos = {x = pos.x - 1, y = pos.y, z = pos.z}
		elseif dir >= 4 then rot = "0" pos = {x = pos.x, y = pos.y, z = pos.z - 1}
		end

		core.place_schematic(pos,schem,rot, "air", true)

		itemstack:take_item()

		core.show_formspec(placer:get_player_name(),"portal_fs",
			"size[4.5,5;]"..
			"background[-0.5,-0.5;5.5,6;myportal_portal_bg.png]"..
			"field[1,1;4,1;nm;Name;]"..
			"field[1,2;1,1;px;x;]"..
			"field[2,2;1,1;py;y;]"..
			"field[3,2;1,1;pz;z;]"..
			"button_exit[1.25,4;2,1;set;Set]")

		core.register_on_player_receive_fields(function(player, arena_fs, fields)

			if fields["px"]
			and fields["py"]
			and fields["pz"]
			and fields["set"] then
			
				if fields["set"] then
						core.after(0.2, function()
						meta:set_string("posx",fields["px"])
						meta:set_string("posy",fields["py"])
						meta:set_string("posz",fields["pz"])
						metaa:set_string("infotext",fields["nm"])
						end)
					return true
				end
			end
		end)
	end,
	})

core.register_node("myportal:portal", {
	description = "portal",
	drawtype = "mesh",
	mesh = "myportal_portal_gate.obj",
	tiles = {"myportal_portal_gate.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	pointable = false,
	walkable = true,
	drop = "",
	groups = {cracky = 2,not_in_creative_inventory = 1},

	selection_box = {
		type = "fixed",
		fixed = {
			{-0.3125,-0.5,-1.5,0.3125,-0.25,1.5},
			{-0.3125,2.25,-1.5,0.3125,2.5,1.5},
		}
	},

	collision_box = {
		type = "fixed",
		fixed = {
			{-0.3125,-0.5,-1.5,0.3125,-0.25,1.5},
			{-0.3125,2.25,-1.5,0.3125,2.5,1.5},
		}
	},

})

core.register_node("myportal:center", {
	description = "center",
	tiles = {{name="myportal_ani_blue.png",
		animation={type="vertical_frames",aspect_w=16, aspect_h=16, length=0.5}}},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	post_effect_color = { r=3, g=42, b=50, a=255 },
	walkable = false,
	drop = "",
	light_source = 14,
	groups = {cracky = 2,not_in_creative_inventory = 1},

	node_box = {
		type = "fixed",
		fixed = {
			{-0.45,-1.25,-0.3125,0.45,0.5,0.3125},
			{-1.25,-0.45,-0.3125,1.25,0.5,0.3125},
			{-0.9,-1,-0.3125,0.9,0.5,0.3125},
			{-0.65,-1.25,-0.3125,0.65,0.5,0.3125},
			{-1.15,-0.75,-0.3125,1.15,0.5,0.3125},
		}
	},

	selection_box = {
		type = "fixed",
		fixed = {
			{-1.5,-1.5,-0.5,1.5,1.5,0.5},
		}
	},

	collision_box = {
		type = "fixed",
		fixed = {
			{-1.5,-1.5,-0.5,1.5,1.5,0.5},
		}
	},

	on_destruct = function(pos)
	local p = core.find_nodes_in_area({x=pos.x-2, y=pos.y-2, z=pos.z-2},
				{x=pos.x+2, y=pos.y+2, z=pos.z+2},
				{"myportal:portal","myportal:centerb","myportal:hidden"})

		for _,ps in ipairs(p) do
		core.remove_node(ps)
		end
	end,
})

core.register_node("myportal:centerb", {
	description = "center",
	tiles = {{name="myportal_ani_blue.png",
		animation={type="vertical_frames",aspect_w=16, aspect_h=16, length=0.5}}},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	post_effect_color = { r=3, g=42, b=50, a=250 },
	pointable = false,
	drop = "",
	light_source = 14,
	groups = {cracky = 2,not_in_creative_inventory = 1},

	node_box = {
		type = "fixed",
		fixed = {
			{-0.45,-0.5,-0.3125,0.45,0.25,0.3125},
			{-0.9,-0.5,-0.3125,0.9,	0,0.3125},
			{-0.65,-0.5,-0.3125,0.65,0.25,0.3125},
			{-1.15,-0.5,-0.3125,1.15,-0.25,0.3125},
		}
	},

	selection_box = {
		type = "fixed",
		fixed = {
			{-1.5, 2.25, -0.3125, 1.5, 2.5, 0.3125},
		}
	},

	collision_box = {
		type = "fixed",
		fixed = {
			{-1.5, 2.25, -0.3125, 1.5, 2.5, 0.3125},
		}
	},
})

core.register_node("myportal:hidden", {
	description = "hidden",
	tiles = {"myportal_hidden.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	pointable = true,
	drop = "",
	groups = {cracky = 2,not_in_creative_inventory = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.25, 0.5, 0.5},
		}
	}
})

core.register_abm({
	nodenames = {"myportal:center"},
	interval = 0.5,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)

		local meta = core.get_meta({x = pos.x, y = pos.y - 1, z = pos.z})
		local p1 = tonumber(meta:get_string("posx")) or pos.x
		local p2 = tonumber(meta:get_string("posy")) or pos.y
		local p3 = tonumber(meta:get_string("posz")) or pos.z + 3
		spawn_spot = {x=p1, y=p2, z=p3}

		local objs = core.get_objects_inside_radius({x = pos.x, y = pos.y - 1, z = pos.z}, 1)

		for k, player in pairs(objs) do

			if player:get_player_name() then

				if core.get_player_privs(player:get_player_name()).interact == true then

					parti(pos)
					player:setpos(spawn_spot)
					parti2(spawn_spot)

				end
			end
		end
	end
})

