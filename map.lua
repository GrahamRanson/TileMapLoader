--- Required libraries.
local Utils = require( "TileMapLoader.lib.utils" )

--- Required libraries.
local Tileset = require( "TileMapLoader.tileset" )
local TileLayer = require( "TileMapLoader.layers.tile" )
local ImageLayer = require( "TileMapLoader.layers.image" )
local ObjectLayer = require( "TileMapLoader.layers.object" )

-- Localised functions.
local floor = math.floor

-- Localised values.

--- Class creation.
local Map = {}

--- Initiates a new Map object.
-- @return The new Map.
function Map.new( path )

	-- Create ourselves
	local self = display.newGroup()

    self._data = Utils:decodeJsonFile( path )

    self._tilesets = {}
	self._tileLayers = {}
	self._imageLayers = {}
	self._objectLayers = {}

	function self.getColumns()
		return self._data.width
	end

	function self.getRows()
		return self._data.height
	end

	function self.getTileSize()
		return { width = self.getTileWidth(), height = self.getTileHeight() }
	end

	function self.getTileWidth()
		return self._data.tilewidth
	end

	function self.getTileHeight()
		return self._data.tileheight
	end

	function self.getOrientation()
		return self._data.orthogonal
	end

	function self.getRenderOrder()
		return self._data.renderorder
	end

	function self.getTileLayer( name )
		for i = 1, #( self._tileLayers or {} ), 1 do
			if self._tileLayers[ i ].getName() == name then
				return self._tileLayers[ i ]
			end
		end
	end

	function self.getLayers()

	end

	function self.worldToMap( x, y )
		return floor( x / self.getTileWidth() ), floor( y / self.getTileHeight() ) + 1
	end

	function self.render( column, row, width, height )
		for i = 1, #self._tileLayers, 1 do
			self._tileLayers[ i ].render( column, row, width, height )
		end
	end

	function self.getObjectLayer( name )
		for i = 1, #self._objectLayers, 1 do
			if self._objectLayers[ i ].getName() == name then
				return self._objectLayers[ i ]
			end
		end
	end

	function self.getTilesetFromGID( gid )
		if gid then
			for i = 1, #self._tilesets, 1 do
				if self._tilesets[ i ].getFirstGID() and gid >= self._tilesets[ i ].getFirstGID() and self._tilesets[ i ].getLastGID() and gid <= self._tilesets[ i ].getLastGID() then
					return self._tilesets[ i ]
				end
			end
		end
	end

	for i = 1, #self._data.tilesets, 1 do
		self._tilesets[ #self._tilesets + 1 ] = Tileset.new( self._data.tilesets[ i ] )
	end

    for i = 1, #self._data.layers, 1 do
        if self._data.layers[ i ].type == "tilelayer" then
            self._tileLayers[ #self._tileLayers + 1 ] = TileLayer.new( self, self._data.layers[ i ] )
        elseif self._data.layers[ i ].type == "objectgroup" then
            self._objectLayers[ #self._objectLayers + 1 ] = ObjectLayer.new( self, self._data.layers[ i ] )
		elseif self._data.layers[ i ].type == "imagelayer" then
            self._imageLayers[ #self._imageLayers + 1 ] = ImageLayer.new( self, self._data.layers[ i ] )
        end
	end

    -- Return the Map object
	return self

end

return Map
