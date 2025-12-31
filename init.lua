local current_portal_pos = {}

core.register_privilege("myportal", {
	description = "Place Portals",
	give_to_singleplayer = true
})

local function parti(pos)
	core.add_particlespawner(50, 0.4,
		{x=pos.x + 0.5, y=pos.y, z=pos.z + 0.5}, {x=pos.x - 0.5, y=pos.y, z=pos.z - 0.5},
		{x=0, y=5, z=0}, {x=0, y=0, z=0},
		{x=0, y=5, z=0}, {x=0, y=0, z=0},
		3, 5, 3, 5, false, "myportal_portal_parti.png")
end

local function parti2(pos)
	core.add_particlespawner(50, 0.4,
		{x=pos.x + 0.5, y=pos.y + 10, z=pos.z + 0.5}, {x=pos.x - 0.5, y=pos.y, z=pos.z - 0.5},
		{x=0, y=-5, z=0}, {x=0, y=0, z=0},
		{x=0, y=-5, z=0}, {x=0, y=0, z=0},
		3, 5, 3, 5, false, "myportal_portal_parti.png")
end

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
	groups = {cracky = 2, not_in_creative_inventory = 1},
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
	tiles = {{name="myportal_ani_blue.png", animation={type="vertical_frames",aspect_w=16, aspect_h=16, length=0.5}}},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	post_effect_color = { r=3, g=42, b=50, a=255 },
	walkable = false,
	drop = "",
	light_source = 14,
	groups = {cracky = 2, oddly_breakable_by_hand = 1, not_in_creative_inventory = 1},
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
	selection_box = { type = "fixed", fixed = {{-1.5,-1.5,-0.5,1.5,1.5,0.5}} },
	collision_box = { type = "fixed", fixed = {{-1.5,-1.5,-0.5,1.5,1.5,0.5}} },
	
	on_dig = function(pos, node, digger)
		if not digger then return end
		local name = digger:get_player_name()
		
		if not core.get_player_privs(name).myportal then
			core.chat_send_player(name, "You need the myportal priv to remove this!")
			return
		end

		local inv = digger:get_inventory()
		local stack = ItemStack("myportal:portal_placer")
		if inv:room_for_item("main", stack) then
			inv:add_item("main", stack)
		else
			core.add_item(pos, stack)
		end

		local p = core.find_nodes_in_area({x=pos.x-2, y=pos.y-2, z=pos.z-2}, {x=pos.x+2, y=pos.y+2, z=pos.z+2}, {"myportal:portal","myportal:center","myportal:centerb","myportal:hidden"})
		for _,ps in ipairs(p) do 
			core.remove_node(ps) 
		end
	end,
})

core.register_node("myportal:centerb", {
	description = "center",
	tiles = {{name="myportal_ani_blue.png", animation={type="vertical_frames",aspect_w=16, aspect_h=16, length=0.5}}},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	post_effect_color = { r=3, g=42, b=50, a=250 },
	pointable = false,
	drop = "",
	light_source = 14,
	groups = {cracky = 2, not_in_creative_inventory = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.45,-0.5,-0.3125,0.45,0.25,0.3125},
			{-0.9,-0.5,-0.3125,0.9,	0,0.3125},
			{-0.65,-0.5,-0.3125,0.65,0.25,0.3125},
			{-1.15,-0.5,-0.3125,1.15,-0.25,0.3125},
		}
	},
	selection_box = { type = "fixed", fixed = {{-1.5, 2.25, -0.3125, 1.5, 2.5, 0.3125}} },
	collision_box = { type = "fixed", fixed = {{-1.5, 2.25, -0.3125, 1.5, 2.5, 0.3125}} },
})

core.register_node("myportal:hidden", {
	description = "hidden",
	tiles = {"myportal_hidden.png"},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	pointable = true,
	drop = "",
	groups = {cracky = 2, not_in_creative_inventory = 1},
	node_box = { type = "fixed", fixed = {{-0.5, -0.5, -0.5, 0.25, 0.5, 0.5}} }
})

core.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "portal_fs" then return end
	local name = player:get_player_name()
	local pos = current_portal_pos[name]
	if not pos then return end

	if fields.set then
		local meta = core.get_meta(pos)
		local metaa = core.get_meta({x = pos.x, y = pos.y + 1, z = pos.z})
		meta:set_string("posx", fields.px)
		meta:set_string("posy", fields.py)
		meta:set_string("posz", fields.pz)
		metaa:set_string("infotext", fields.nm)
		core.chat_send_player(name, "Portal set!")
		current_portal_pos[name] = nil
		return true
	end

	if fields.quit then
		local p = core.find_nodes_in_area({x=pos.x-2, y=pos.y-2, z=pos.z-2}, {x=pos.x+2, y=pos.y+2, z=pos.z+2}, {"myportal:portal","myportal:center","myportal:centerb","myportal:hidden"})
		if #p > 0 then
			for _,ps in ipairs(p) do core.remove_node(ps) end
			local inv = player:get_inventory()
			local item = ItemStack("myportal:portal_placer")
			if inv:room_for_item("main", item) then
				inv:add_item("main", item)
			else
				core.add_item(player:get_pos(), item)
			end
		end
		current_portal_pos[name] = nil
	end
end)

core.register_node("myportal:portal_placer", {
	description = "Portal Placer",
	tiles = {"myportal_metal.png"},
	paramtype2 = "facedir",
	groups = {cracky = 2},
	on_place = function(itemstack, placer, pointed_thing)
		local name = placer:get_player_name()
		if not core.get_player_privs(name).myportal then
			core.chat_send_player(name, "You need the myportal priv")
			return itemstack
		end

		local pos = pointed_thing.above
		local dir = core.dir_to_facedir(placer:get_look_dir())
		
		local nearby = core.find_nodes_in_area({x=pos.x-2, y=pos.y-2, z=pos.z-2}, {x=pos.x+2, y=pos.y+2, z=pos.z+2}, {"myportal:center"})
		if #nearby > 0 then
			core.chat_send_player(name, "Too close to another portal!")
			return itemstack
		end

		local can_place = true
		for y = 0, 2 do
			for offset = -1, 1 do
				local check_pos
				if dir == 0 or dir == 2 then
					check_pos = {x = pos.x + offset, y = pos.y + y, z = pos.z}
				else
					check_pos = {x = pos.x, y = pos.y + y, z = pos.z + offset}
				end
				if core.get_node(check_pos).name ~= "air" then
					can_place = false
					break
				end
			end
		end

		if not can_place then
			core.chat_send_player(name, "Not enough space! Area must be 3x3 clear air.")
			return itemstack
		end

		local schem = core.get_modpath("myportal").."/schems/myportal.mts"
		local rot = (dir == 1 or dir == 3) and "90" or "0"
		local p_pos = pos
		if dir == 1 or dir == 3 then p_pos = {x=pos.x, y=pos.y, z=pos.z-1} else p_pos = {x=pos.x-1, y=pos.y, z=pos.z} end

		core.place_schematic(p_pos, schem, rot, "air", true)
		current_portal_pos[name] = pos

		core.show_formspec(name, "portal_fs",
			"size[4.5,5]background[-0.5,-0.5;5.5,6;myportal_portal_bg.png]"..
			"field[1,1;4,1;nm;Name;Name of Portal]"..
			"field[1,2;1,1;px;x;0]field[2,2;1,1;py;y;0]field[3,2;1,1;pz;z;0]"..
			"button_exit[1.25,4;2,1;set;Set]")

		itemstack:take_item()
		return itemstack
	end,
})

core.register_abm({
	nodenames = {"myportal:center"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node)
		local meta = core.get_meta({x = pos.x, y = pos.y - 1, z = pos.z})
		local px = meta:get_string("posx")
		if px == "" then return end
		
		local target = {x = tonumber(px), y = tonumber(meta:get_string("posy")), z = tonumber(meta:get_string("posz"))}
		local detect_pos = {x = pos.x, y = pos.y - 0.7, z = pos.z}
		local objs = core.get_objects_inside_radius(detect_pos, 1.2)
		
		for _, obj in pairs(objs) do
			if obj:is_player() then
				parti(pos)
				obj:set_pos({x=target.x, y=target.y + 0.5, z=target.z})
				parti2(target)
			end
		end
	end
})

core.register_craft({
	output = "myportal:portal_placer 9",
	recipe = {
		{"default:diamond", "default:mese","default:diamond"},
		{"default:mese", "default:diamond_block","default:mese"},
		{"default:diamond", "default:mese","default:diamond"},
	}
})
