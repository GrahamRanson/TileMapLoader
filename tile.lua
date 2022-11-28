-- Required libraries.

-- Localised functions.

-- Localised values.

--- Class creation.
local Tile = {}

--- Initiates a new Tile object.
-- @return The new Tile.
function Tile.new( data )

	local tileset = data.map.getTilesetFromGID( data.gid )

	local size

	if tileset then
		size = tileset.getTileSize()
	else
		size = { width = 32, height = 32 }
	end

	-- Create ourselves
	local self = display.newRect( ( ( data.column - 1 ) * data.map.getTileWidth() ) + size.width * 0.5, ( ( data.row - 1 ) * data.map.getTileHeight() ) + size.height * 0.5, size.width, size.height )

    self._map = data.map
    self._gid = data.gid
    self._column = data.column
    self._row = data.row
    self._tileset = tileset

    if self._tileset then

        self.fill =
        {
            type = "image",
            sheet = self._tileset.getImageSheet(),
            frame = ( self._gid - self._tileset.getFirstGID() ) + 1
        }

    else
        self.isVisible = false
    end

	function self.sleep()
		self.isVisible = false
		self._sleeping = true
	end

	function self.wake()
		self.isVisible = true
		self._sleeping = false
	end

	function self.isAwake()
		return not self.isSleeping()
	end

	function self.isSleeping()
		return self._sleeping
	end

    -- Return the Tile object
	return self

end

return Tile
