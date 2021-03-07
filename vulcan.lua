-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
local function findlava(pos)
	return nodecore.find_nodes_around(pos, "group:lava")
end

--Vulcanize Soil--
nodecore.register_abm({
		label = "Vulcanize Soil",
		nodenames = {"group:soil"},
		neighbors = {"nc_terrain:lava_source", "nc_terrain:lava_flowing"},
		interval = 4,
		chance = 2,
		action = function(pos)
			nodecore.set_loud(pos, {name = "nc_concrete:adobe"})
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


