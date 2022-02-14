-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
    = minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()

--local function findlava(pos)
--	return nodecore.find_nodes_around(pos, "group:lava")
--end

--Vulcanize Soil--
nodecore.register_abm({
		label = "Vulcanize Soil",
		nodenames = {"group:soil"},
		neighbors = {"nc_terrain:lava_source", "nc_terrain:lava_flowing"},
		interval = 20,
		chance = 10,
		action = function(pos)
			nodecore.set_loud(pos, {name = "nc_concrete:adobe"})
		end
	})

--Vulcanize Sand--
nodecore.register_abm({
		label = "Vulcanize Sand",
		nodenames = {"group:sand"},
		neighbors = {"nc_terrain:lava_source", "nc_terrain:lava_flowing"},
		interval = 20,
		chance = 10,
		action = function(pos)
			nodecore.set_loud(pos, {name = "nc_concrete:sandstone"})
		end
	})

--Vulcanize Gravel--
nodecore.register_abm({
		label = "Vulcanize Gravel",
		nodenames = {"nc_terrain:gravel"},
		neighbors = {"nc_terrain:lava_source", "nc_terrain:lava_flowing"},
		interval = 20,
		chance = 10,
		action = function(pos)
			nodecore.set_loud(pos, {name = "nc_terrain:stone"})
		end
	})
	
--Vulcanize Carbon--
nodecore.register_abm({
		label = "Vulcanize Carbon",
		nodenames = {"nc_tree:tree","nc_tree:root","nc_fire:coal8","group:mossy", "wc_coal:lignite", "wc_coal:bituminite", "wc_coal:anthracite"},
		neighbors = {"nc_terrain:lava_source", "nc_terrain:lava_flowing"},
		interval = 20,
		chance = 10,
		action = function(pos)
			nodecore.set_loud(pos, {name = "nc_concrete:coalstone"})
		end
	})

