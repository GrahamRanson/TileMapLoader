-- Required libraries.
local Object = require( "TileMapLoader.object" )

-- Localised functions.

-- Localised values.

--- Class creation.
local ObjectLayer = {}

--- Initiates a new ObjectLayer object.
-- @return The new ObjectLayer.
function ObjectLayer.new( map, data )

	-- Create ourselves
	local self = display.newGroup()

    self._draworder = data.draworder
    self._id = data.id
    self._name = data.name
    self._opacity = data.opacity
    self._type = data.type
    self._visible = data.visible
    self._objects = data.objects
    self._x = data.x
    self._y = data.y
    self._map = map


    for i = 1, #self._objects, 1 do

        self._objects[ i ] = Object.new( self, self._objects[ i ] )


    end

    self.alpha = self._opacity
	self.isVisible = self._visible

    map:insert( self )

    function self.getName()
        return self._name
    end

    function self.getObjects()
        return self._objects
    end

    -- Return the ObjectLayer object
	return self

end

return ObjectLayer
