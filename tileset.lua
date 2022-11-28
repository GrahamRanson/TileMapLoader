--- Required libraries.
local xml = require( "TileMapLoader.lib.xmlSimple" ).newParser()

--- Required libraries.

-- Localised functions.

-- Localised values.

--- Class creation.
local Tileset = {}

--- Initiates a new Tileset object.
-- @return The new Tileset.
function Tileset.new( data )

	-- Create ourselves
	local self = {}

    local extractData = function( data )

        self._data = data
        self._firstGID = data.firstgid
        self._size = { columns = data.columns, rows = data.rows }
        self._image = { filename = data.image, width = data.imagewidth, height = data.imageheight }
        self._margin = data.margin
        self._spacing = data.spacing
        self._name = data.name
        self._tileSize = { width = data.tilewidth, height = data.tileheight }
        self._tileCount = data.tilecount

    end

    if data.source then
        print("EXTERNAL")
    else
        extractData( data )
    end

	function self.getImageSheet()

		local options =
		{
		    width = self._tileSize.width,
		    height = self._tileSize.height,
		    numFrames = self._tileCount,
			sheetContentWidth = self._image.width,
    		sheetContentHeight = self._image.height
		}

		display.setDefault( "magTextureFilter", "nearest" )
		display.setDefault( "minTextureFilter", "nearest" )
		self._imageSheet = self._imageSheet or graphics.newImageSheet( self._image.filename, system.ResourceDirectory, options )
		display.setDefault( "magTextureFilter", "linear" )
		display.setDefault( "minTextureFilter", "linear" )

		return self._imageSheet

	end

	function self.getName()
		return self._name
	end

	function self.getFirstGID()
		return self._firstGID
	end

	function self.getLastGID()
		return self._firstGID + self.getTileCount() - 1
	end

	function self.getTileCount()
		return self._tileCount
	end

	function self.getTileSize()
		return self._tileSize
	end

	function self.getTileWidth()
		return self.getTileSize().width
	end

	function self.getTileHeight()
		return self.getTileSize().height
	end

	function self.getOrientation()
		return self._data.orthogonal
	end

    -- Return the Tileset object
	return self

end

return Tileset
