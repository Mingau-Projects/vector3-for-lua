
# Vector3 for Lua
This is a little library i made on lua that imitates the Vector3 object from Roblox's Luau, but with extra Methods and some different namings.

## Usage:

    --// Requiring the library:
    local Vector3 = require("Vector3")
    
    --// Creating a vector:
    local vector = Vector3.new(10, 32, 44)

## Examples:

### Length
    local vector = Vector3.new(10, 32, 44)
    
    --// Get and print a vector's length:
    local length = vector:Length()
    print(length)

### Distance between two points

    local v = Vector3.new(10, 32, 44)
    local w = Vector3.new(3, 55, 21)
    
    --// Prints the distance between v and w
    print(v:Distance(w))
    
    --// Or you can get the squared one (faster)
    print(v:DistanceSquared(w))
 
### Scale a vector

    local vector = Vector3.new(5, 3, 1)
    print(tostring(vector:Scale(3))) 
    --[[ Will print 
	    {
		    X: 15, 
		    Y: 9, 
		    Z: 3
	    }
	]]

### Dot product

    local v = Vector3.new(10, 32, 33)
    local w = Vector3.new(12, 66, 9)
    
    print(v:Dot(w))

 ***
***And many more things you can do***

***Im still working on a matrix module too!***
