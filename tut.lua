print("Hello World!")

local name = 'Josh'
-- # is most common way to get number of chars in string
local nameSize = #name;
-- another way to do this
local nameSizeLen = string.len(name);

io.write("Size name string: ", nameSize, "\n")

name = 4;
io.write("Changed type of 'name' to: ", type(name), "\n")

local longString = [[
    I am a very very long string
    that goes on many
    lines.
]]

longString = longString .. "\nOi."
io.write(longString, "\n")

isWritable = true;
io.write("should be bool type: ", type(isWritable), "\n")

io.write("uninit type: ", type(madeUpVar), "\n")

-- math functions:
-- math.floor, ceil, min, max sin, asin, exp, log, log10, pow, sqrt, random, randomseed, etc.

-- common way to seed rng:
math.randomseed(os.time())
-- [0, 1)
math.random()
-- [1, 10]
math.random(10)
-- [-1, 1]
math.random(-1, 1)
-- NOTE: 13 digits is the max precision in lua
print(string.format("Pi = %.13f", math.pi), "\n")

-- boolean neq is ~=
-- logical ops are 'and', 'or', and 'not'
local age = 13
if age < 16 then
    io.write("You can go to school", "\n")
    local localVar = 10
elseif age >= 16 and age < 18 then
    io.write("You can go to drive", "\n")
else
    io.write("You can go to vote", "\n")
end

print('localVar should be nil here: ', type(localVar))
print(string.format("not true = %s", tostring(not true)), "\n")
-- ternary op in lua
-- other langs: bool canVote = age >= 18 ? 0 : 1
local canVote = age >= 18 and true or false

local myString = "I I I I oy oy oy oy"
io.write("replace I with me in myString: ", string.gsub(myString, "I", "me"), "\n")
io.write("Index of oy : ", string.find(myString, "oy"), "\n")
io.write("upper myString : ", string.upper(myString), "\n")
io.write("lower myString : ", string.lower(myString), "\n")

-- NOTE: no ++, continue, switch operators in lua

local p = 1
while (p <= 10) do
    io.write(p)
    p = p + 1
    if p == 8 then
        break
    end
end

-- -- how to do a 'do while' in lua
-- repeat
--     io.write("\nEnter your guess: ");
--     guess = io.read();
-- until tonumber(guess) == 7

-- 1 through 10 inclusive
for j = 1, 10, 1 do
    io.write(j)
end

-- a table
local months = {
    "Jan", "Feb", "Mar", "April",
}

for _, value in pairs(months) do
    io.write(value, " ")
end

local aTable = {}
for j = 1, 10 do
    aTable[j] = j
end

io.write("First: ", aTable[1], "\n")

io.write("Number of items : ", #aTable, "\n")

table.insert(aTable, 1, 0)
io.write("First : ", aTable[1], "\n")

-- convert aTable to string
print(table.concat(aTable, ", "), "\n")

table.remove(aTable, 1)
print(table.concat(aTable, ", "), "\n")

local aMultiTable = {}

for j = 0, 9 do
    aMultiTable[j] = {}
    for k = 0, 9 do
    aMultiTable[j][k] = tostring(j) .. tostring(k)
    end
end


for j = 0, 9 do
    io.write("\n")
    for k = 0, 9 do
        io.write(aMultiTable[j][k], " : ")
    end
end

io.write("\nSize of first dim in aMultiTable : ", #aMultiTable, "\n")
io.write("\nSize of second dim in aMultiTable : ", #aMultiTable[0], "\n")

local function getSum(num1, num2)
    return num1 + num2
end

print(string.format(" 5 + 2 = %d", getSum(5, 2)), "\n")

local function splitStr(theString)
    local stringTable = {}
    local i = 0
    -- this is a regex
    for word in string.gmatch(theString, "[^%s]+") do
        stringTable[i] = word
        i = i + 1
    end

    return stringTable, i
end

local splitStrTable, numOfStr = splitStr("The Turtle")

io.write("\n")
for j = 0, numOfStr - 1 do
    print(string.format("%d : %s", j, splitStrTable[j]))
end

local function getSumMore(...)
    local sum = 0
    for _, v in pairs{...} do
        sum = sum + v
    end
    return sum
end

io.write("Sum ", getSumMore(1,2,3,4,5,6), "\n")

local doubleIt = function(x)
    return x * 2
end

print(doubleIt(4))

-- closure can access local vars of an enclosing func

local function outerFunc()
    local i = 0

    -- inner func can remember changes to i
    return function()
        i = i + 1
        return i
    end
end

local getI = outerFunc()

print(getI())
print(getI())


-- coroutine
co = coroutine.create(
    function()
        for i = 1, 10, 1 do
            print(i)
            print(coroutine.status(co))
            if i == 5 then
                coroutine.yield()
            end
        end
    end
)

print(coroutine.status(co))
coroutine.resume(co)
print(coroutine.status(co))

co2 = coroutine.create(
    function()
        for i = 101, 110, 1 do
            print(i)
        end
    end
)

coroutine.resume(co2)
coroutine.resume(co)
print(coroutine.status(co))

-- file io
-- r: read only (default)
-- o: overwrite or create
-- a: append or create
-- r+: read & write existing
-- w+: overwrite, read or create
-- a+: append, read or create

file = io.open("test.lua", "w+")
file:write("Random string of text\n")
file:write("Some more text\n")

-- go back to beginning
file:seek("set", 0)

-- read entire file and print it
print(file:read("*a"))
file:close()

-- open for appending
file = io.open("test.lua", "a+")
file:write("Appended text\n")
file:seek("set", 0)
print(file:read("*a"))
file:close()

-- modules
-- file must be named convert
local convertModuleFileName = "convert.lua"
local convertModuleLuaCode = [[
convert = {}
function convert.ftToCm(feet)
    return feet + 30.48
end
return convert
]]
file = io.open(convertModuleFileName, "w+")
file:write(convertModuleLuaCode)
file:seek("set", 0)
print(file:read("*a"))
file:close()

-- How to import a module
convert = require("convert")
print(string.format("\n%.3f cm", convert.ftToCm(1)), "\n")

-- metatables
-- control how operations on tables work
mt = {
    __add = function(table1, table2)
        local resultTable = {}
        for y = 1, #table1 do
            if(table1[y] ~= nil) and (table2[y] ~= nil) then
                resultTable[y] = table1[y] + table2[y]
            else
                resultTable[y] = 0
            end
        end
        return resultTable
    end,

    __mult = function(table1, table2)
        local resultTable = {}
        for y = 1, #table1 do
            if(table1[y] ~= nil) and (table2[y] ~= nil) then
                resultTable[y] = table1[y] * table2[y]
            else
                resultTable[y] = 0
            end
        end
        return resultTable
    end,

    __div = function(table1, table2)
        local resultTable = {}
        for y = 1, #table1 do
            if(table1[y] ~= nil) and (table2[y] ~= nil) then
                resultTable[y] = table1[y] / table2[y]
            else
                resultTable[y] = 0
            end
        end
        return resultTable
    end,

    __eq = function(table1, table2)
        return table1.value == table2.value
    end,

    __lt = function(table1, table2)
        return table1.value < table2.value
    end,

    __le = function(table1, table2)
        return table1.value <= table2.value
    end,
}

local btable = {}

for x = 1, 10 do
    btable[x] = x
end

setmetatable(btable, mt)

print(btable == btable)
local addTable = btable + btable
print("\n")
for z = 1, #addTable do
    print(addTable[z])
end

-- oop is faked via tables and metatables
Animal = { height = 0, weight = 0, name = "No Name", sound = "No Sound" }
function Animal:new(height, weight, name, sound)
    setmetatable({}, Animal)
    self.height = height
    self.weight = weight
    self.name = name
    self.sound = sound

    return self
end

function Animal:toString()
    local animalStr = string.format(
        "%s weighs %.1f lbs, is %.1f inches tall and says %s",
        self.name,
        self.weight,
        self.height,
        self.sound
    )
    return animalStr
end

local spot = Animal:new(1, 2, 'Spot', "Moo")
print(spot.name)
print(spot:toString())

-- how to do inheritance
-- grab all of the functionality of Animal
Cat = Animal:new()

function Cat:new(height, weight, name, sound, favFood)
    setmetatable({}, Cat)
    self.height = height
    self.weight = weight
    self.name = name
    self.sound = sound
    self.favFood = favFood

    return self
end


function Cat:toString()
    local str = string.format(
        "%s weighs %.1f lbs, is %.1f inches tall, says %s, favFood %s",
        self.name,
        self.weight,
        self.height,
        self.sound,
        self.favFood
    )
    return str
end

fluffy = Cat:new(10, 15, "Fluffy", "Meow", "Tuna")
print(fluffy.favFood)
print(fluffy:toString())
