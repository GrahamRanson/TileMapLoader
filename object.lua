-- Required libraries.
local json = require( "json" )

-- Localised functions.

-- Localised values.

--- Class creation.
local Object = {}

--- Initiates a new Object.
-- @return The new Object.
function Object.new( layer, data )

	-- Create ourselves
	local self

    if data.point then
        self = display.newCircle( data.x + 16, data.y - 16, 1 )
    elseif data.width > 0 and data.height > 0 then
        self = display.newRect( data.x, data.y, data.width, data.height )
    elseif data.polygon then

        local vertices = {}
        for i = 1, #data.polygon, 1 do
            vertices[ #vertices + 1 ] = data.polygon[ i ].x
            vertices[ #vertices + 1 ] = data.polygon[ i ].y
        end

        self = display.newPolygon( data.x, data.y, vertices )
        self.x = self.x - self.contentWidth * 0.5
        self.y = self.y - self.contentHeight * 0.5

        self._vertices = vertices

    end

    self:setFillColor( 1, 1, 1, 0.5 )
    self:setStrokeColor( 1, 1, 1 )
    self.strokeWidth = 1

	self._class = data.class
	self._height = data.height
	self._id = data.id
	self._name = data.name
	self._point = data.point
	self._rotation = data.rotation
	self._visible = data.visible
	self._width = data.width
	self._x = data.x
	self._y = data.y
    self._polygon = data.polygon
    self._properties = {}

    local properties = data.properties or {}
    for i = 1, #properties, 1 do
        self._properties[ properties[ i ].name ] = properties[ i ].value
    end

    function self.createDebugDisplay()

        local content = ""

        if self._name ~= "" then
            content = content .. self._name
        end

        if self._class ~= "" then
            content = content .. " (" .. self._class .. ")"
        end

        for k, v in pairs( self._properties ) do
            content = content .. "\n" .. k .. ": " .. tostring( v )
        end

        local options =
        {
            text = content,
            x = 0,
            y = 0,
            font = native.systemFontBold,
            fontSize = 8
        }

        self._debugDisplay = display.newGroup()

        local textShadow = display.newText( options )
        textShadow.x = 0.5
        textShadow.y = 0.5
        textShadow:setFillColor( 0, 0, 0 )
        local text = display.newText( options )

        local shadow = display.newRoundedRect( self._debugDisplay, 0.5, 0.5, text.contentWidth + 10, text.contentHeight + 5, 3 )
        shadow:setFillColor( 0, 0, 0 )

        local back = display.newRoundedRect( self._debugDisplay, 0, 0, text.contentWidth + 10, text.contentHeight + 5, 3 )
        back:setFillColor( 0.75, 0.75, 0.75 )

        self._debugDisplay:insert( textShadow )
        self._debugDisplay:insert( text )

        self._debugDisplay.x = self.x
        self._debugDisplay.y = self.y - self.contentHeight * 0.5 - self._debugDisplay.contentHeight * 0.75

        layer:insert( self._debugDisplay )

    end

    function self.destroyDebugDisplay()
        display.remove( self._debugDisplay )
        self._debugDisplay = nil
    end

    function self.getProperty( name )
        return self._properties[ name ]
    end

    self.createDebugDisplay()

	layer:insert( self )

    -- Return the Object
	return self

end

return Object
