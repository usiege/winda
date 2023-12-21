-- 定义 Object 类
local Object = {
    __classname = "Object",
    __subclass = {},
}

-- 创建一个新的 Object 对象
function Object:new(args)
    local newObj = { __class = Object }
    setmetatable(newObj, { __index = self })
    for k,v in pairs(args) do
        self.v = k
    end
    
    return newObj
end

-- 获取类名
function Object:className()
    return self.__classname
end

-- 判断是否为某个类的实例
function Object:isKindOfClass(class)
    local currentClass = self.__class
    while currentClass do
        if currentClass == class then
            return true
        end
        currentClass = currentClass.superclass
    end
    return false
end

-- 类方法：获取父类名
function Object:superclassName()
    if self.superclass then
        return self.superclass.__classname
    else
        return nil
    end
end

-- 类方法：创建子类
function Object:createSubclass(classname)
    local subclass = { __classname = classname, superclass = self }
    self.__subclass[classname] = subclass
    setmetatable(subclass, { __index = self })
    return subclass
end

--[[
comment...
-- 示例用法
local obj = Object:new()
print(obj:className())  -- 输出: Object
print(obj:isKindOfClass(Object))  -- 输出: true
print(obj:superclassName())  -- 输出: nil

-- 创建子类
local Subclass = Object:createSubclass("Subclass")
local subObj = Subclass:new()
print(subObj:className())  -- 输出: Subclass
print(subObj:isKindOfClass(Object))  -- 输出: true
print(subObj:superclassName())  -- 输出: Object
]]

_G["Object"]  = Object
return Object


