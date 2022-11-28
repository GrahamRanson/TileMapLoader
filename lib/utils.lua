--- Required libraries.
local json = require( "json" )

--- Required libraries.

-- Localised functions.
local readInFile = system.readInFile
local pathForFile = system.pathForFile
local open = io.open
local close = io.close
local decode = json.decode

-- Localised values.
local ResourceDirectory = system.ResourceDirectory

--- Class creation.
local utils = {}

--- Decodes the contents of a file that has been encoded as json.
-- @param path The path to the file.
-- @param baseDir The directory that the file resides in. Optional, defaults to system.DocumentsDirectory.
-- @return The decoded file as a table.
function utils:decodeJsonFile( path, baseDir )
	return self:jsonDecode( self:readInFile( path, baseDir ) )
end

--- Decodes a Json string into a table.
-- @param string The string to decode.
-- @return The decoded table.
function utils:jsonDecode( string )
	return decode( string or "" )
end

--- Reads in a file from disk.
-- @param path The path to the file.
-- @param baseDir The directory that the file resides in. Optional, defaults to system.ResourceDirectory.
-- @return The contents of the file, or an empty string if the read failed.
function utils:readInFile( path, baseDir )

	local path = pathForFile( path, baseDir or ResourceDirectory )

	if path then

		local file = open( path, "r" )

		if file then

			local contents = file:read( "*a" ) or ""

			close( file )

			file = nil

			return contents

		end

	end

end

return utils
