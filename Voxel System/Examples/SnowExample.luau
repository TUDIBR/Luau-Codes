---- SNOW EXAMPLE ----
--> LocalScript

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local VoxelSystem = require(ReplicatedStorage.VoxelSystem)

task.wait(3)
local root = script.Parent.HumanoidRootPart

-- Setup
local snow = Instance.new("Part")
snow.Name = "Snow"
snow.CFrame = CFrame.new(Vector3.new(-57.583, 13.188, 10.5)) * CFrame.Angles(0, 0, math.rad(-25))
snow.Size = Vector3.new(80, 8, 8)
snow.BrickColor = BrickColor.new("Ghost grey")
snow.Material = Enum.Material.Sand
snow.Parent = workspace

VoxelSystem.setupVoxel(snow, 1, true, "SnowVoxelBlock")
snow.Parent = nil

local zone =  Instance.new("Part")
zone.Size = Vector3.new(3, 3, 3)
zone.CanCollide = false
zone.Anchored = true
zone.BrickColor = BrickColor.new("Really red")
zone.Transparency = 1
zone.Shape = "Ball"
zone.Parent = workspace



local detectedBlocks = {}
local removedBlocks = {}

local function back(block: Part)
	block.Transparency = 0
end

local function update()
	zone.Position = root.Position - Vector3.new(0, 2, 0)
	detectedBlocks, removedBlocks = VoxelSystem.detectVoxelBlock(zone, "SnowVoxelBlock", detectedBlocks)
	for _, block: Part in ipairs(detectedBlocks) do
		if not table.find(removedBlocks, block) then
			block.Transparency = 1
			task.delay(10, back, block)
		end
	end
end

RunService.RenderStepped:Connect(update)
