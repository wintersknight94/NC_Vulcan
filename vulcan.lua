-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
local function findlava(pos)
	return nodecore.find_nodes_around(pos, "group:lava")
end
----------------------------------------
-----------------NODES------------------

-----Cooled Volcanic Tuff-----
minetest.register_node(modname .. ":tuff", {
		description = "Volcanic Tuff",
		drawtype = "normal",
		tiles = {"(nc_terrain_stone.png^[colorize:#8B4513:80)^(nc_terrain_cobble.png^[colorize:#000000:140)"},
		groups = {
			cracky = 5,
			rock = 1,
			vulcan = 1
			},
		sounds = nodecore.sounds("nc_terrain_stony"),
		drop_in_place = "nc_terrain:hard_stone_3"
	})

-----Hot Volcanic Tuff-----
minetest.register_node(modname .. ":tuff_hot", {
		description = "Hot Volcanic Tuff",
		drawtype = "normal",
		light_source = 6,
		tiles = {"(nc_terrain_stone.png^[colorize:#B22222:80)^(nc_terrain_cobble.png^[colorize:#000000:140)^nc_fire_ember_1.png"},
		groups = {
			cracky = 5,
			igniter = 1,
			damage_touch = 1,
			damage_radiant = 4,
			vulcan = 1
			},
		sounds = nodecore.sounds("nc_terrain_stony"),
		silktouch = false,
		stack_as_node = true,
	})

-----Burning Earth-----
minetest.register_node(modname .. ":dirt_hot", {
		description = "Burning Soil",
		drawtype = "normal",
		light_source = 3,
		tiles = {"nc_terrain_dirt.png^" .. modname .. "_scorch.png^nc_fire_ember_1.png"},
		groups = {
			dirt = 1,
			damage_touch = 1,
			damage_radiant = 2,
			vulcan = 1
			},
		sounds = nodecore.sounds("nc_terrain_crunchy")
	})

-----Scorched Earth-----
minetest.register_node(modname .. ":dirt_ashy", {
		description = "Scorched Soil",
		drawtype = "normal",
		tiles = {"nc_terrain_dirt.png^" .. modname .. "_scorch.png"},
		groups = {
			crumbly = 1,
			dirt = 1,
			soil = 1,
			vulcan = 1,
			falling_repose = 1
			},
		sounds = nodecore.sounds("nc_terrain_crunchy")
	})

-----Basalt-----
minetest.register_node(modname .. ":basalt", {
		description = "Basalt",
		drawtype = "normal",
		tiles = {
			modname .. "_basalt.png",
			modname .. "_basalt.png",
			modname .. "_basalt_side.png",
			},
		groups = {
			cracky = 4,
			falling_node= 1,
			vulcan = 1
			},
		sounds = nodecore.sounds("nc_terrain_stony"),
		drop_in_place = "nc_terrain:cobble",
		drop = "nc_fire:lump_ash"
	})

----------------------------------------
---------------Reactions----------------
--Vulcanize Stone--
nodecore.register_abm({
		label = "Vulcanize Stone",
		nodenames = {"group:rock", "group:gravel"},
		neighbors = {"nc_terrain:lava_source", "nc_terrain:lava_flowing"},
		interval = 4,
		chance = 2,
		action = function(pos)
			nodecore.set_loud(pos, {name = modname .. ":tuff_hot"})
		end
	})

--Vulcanized Stone Cooling--
nodecore.register_abm({
		label = "Volcanic Tuff Cooling",
		interval = 5,
		chance = 5,
		nodenames = {modname .. ":tuff_hot"},
		action = function(pos)
--			local above = {x = pos.x, y = pos.y + 1, z = pos.z}
			if #findlava(pos) < 1 then
				minetest.sound_play("nc_api_craft_hiss", {gain = 0.02, pos = pos})
				return minetest.set_node(pos, {name = modname .. ":tuff"})
			end
		end
	})

--Vulcanize Soil--
nodecore.register_abm({
		label = "Vulcanize Soil",
		nodenames = {"group:soil"},
		neighbors = {"nc_terrain:lava_source", "nc_terrain:lava_flowing"},
		interval = 4,
		chance = 2,
		action = function(pos)
			nodecore.set_loud(pos, {name = modname .. ":dirt_hot"})
		end
	})

--Vulcanized Soil Cooling--
nodecore.register_abm({
		label = "Scorched Soil Cooling",
		interval = 5,
		chance = 5,
		nodenames = {modname .. ":dirt_hot"},
		action = function(pos)
--			local above = {x = pos.x, y = pos.y + 1, z = pos.z}
			if #findlava(pos) < 1 then
				minetest.sound_play("nc_api_craft_hiss", {gain = 0.02, pos = pos})
				return minetest.set_node(pos, {name = modname .. ":dirt_ashy"})
			end
		end
	})

--Vulcanize Sand--
nodecore.register_abm({
		label = "Vulcanize Sand",
		nodenames = {"group:sand"},
		neighbors = {"nc_terrain:lava_source", "nc_terrain:lava_flowing"},
		interval = 10,
		chance = 1,
		action = function(pos)
			nodecore.set_loud(pos, {name = "nc_concrete:sandstone"})
		end
	})

--Hydrovulcanism--
nodecore.register_abm({
		label = "Hydrovolcanic Reaction",
		nodenames = {"group:water"},
		neighbors = {"nc_terrain:lava_flowing"},
		interval = 1,
		chance = 1,
		action = function(pos)
			nodecore.set_loud(pos, {name = modname .. ":basalt"})
			return nodecore.fallcheck(pos)
		end
	})

--Scorched Soil Mixing--
nodecore.register_craft({
		label = "till scorched earth into mud",
		action = "pummel",
		duration = 4,
		toolgroups = {crumbly = 3},
		nodes = {
			{match = modname .. ":dirt_ashy", replace = "nc_concrete:mud"}
		},
		
	})
