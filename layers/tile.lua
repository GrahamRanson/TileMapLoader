-- Required libraries.
local Tile = require( "TileMapLoader.tile" )

-- Localised functions.

-- Localised values.

--- Class creation.
local TileLayer = {}

--- Initiates a new TileLayer object.
-- @return The new TileLayer.
function TileLayer.new( map, data )

	-- Create ourselves
	local self = display.newGroup()

    self._data = data.data
    self._id = data.id
    self._name = data.name
    self._opacity = data.opacity
    self._type = data.type
    self._visible = data.visible
    self._width = data.width
    self._height = data.height
    self._x = data.x
    self._y = data.y
	self._map = map

	self._tiles = {}

	self._columns = 0
	self._rows = 0

	local x, y = 1, 1
	for i = 1, #self._data, 1 do

		self._tiles[ x ] = self._tiles[ x ] or {}

		self._tiles[ x ][ y ] = Tile.new
		{
			map = map,
			column = x,
			row = y,
			gid = self._data[ i ],
			width = 128,
			height = 128
		}

		self:insert( self._tiles[ x ][ y ] )

		x = x + 1
		if y == 1 then
			self._columns = self._columns + 1
		end

		if x > self._width then
			x = 1
			y = y + 1
			self._rows = self._rows + 1
		end

	end

	self.alpha = self._opacity
	self.isVisible = self._visible

	map:insert( self )

	function self.getName()
        return self._name
    end

	function self.render( column, row, width, height )

		--print( self.parent.xScale)

		for x = 1, self._columns, 1 do
			for y = 1, self._rows, 1 do
				self._tiles[ x ][ y ].sleep()
			end
		end
		if self._tiles[ column ] and self._tiles[ column ][ row ] then
			self._tiles[ column ][ row ].wake()
		end


		for x = column - ( width or 0 ), column + ( width or 0 ), 1 do
			for y = row - ( height or 0 ), row + ( height or 0 ), 1 do
				if self._tiles[ x ] and self._tiles[ x ][ y ] then
					self._tiles[ x ][ y ].wake()
				end
			end
		end

	end

    -- Return the TileLayer object
	return self

end

return TileLayer
