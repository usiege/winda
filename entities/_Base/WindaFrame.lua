-- winda base frame
WindaFrame = {
    name = "WindaFrame"
}
setmetatable(WindaFrame, {__index = WindaFrame})
WindaFrame.__index = WindaFrame

function WindaFrame: print()
    print(self.name)
end

function WindaFrame: createButton(args)
    
end
