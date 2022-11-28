--- Required libraries.

--- Required libraries.

-- Localised functions.

-- Localised values.

--- Class creation.
local ImageLayer = {}

--- Initiates a new ImageLayer object.
-- @return The new ImageLayer.
function ImageLayer.new( map, data )

	-- Create ourselves
	local self = display.newGroup()

	function self.getName()
        return self._name
    end
	
    -- Return the ImageLayer object
	return self

end

return ImageLayer
