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
snow.Position = Vector3.new(-63.5, 0.5, 10.5)
snow.Size = Vector3.new(85, 4, 9)
snow.BrickColor = BrickColor.new("Ghost grey")
snow.Material = Enum.Material.Sand
snow.Parent = workspace

VoxelSystem.setupVoxel(snow, 1, true, "VoxelBlock")
snow.Parent = nil

local zone =  Instance.new("Part")
zone.Size = Vector3.new(6, 6, 6)
zone.CanCollide = false
zone.Anchored = true
zone.BrickColor = BrickColor.new("Really red")
zone.Transparency = 1
zone.Shape = "Ball"
zone.Parent = workspace



local detectedBlocks = {}
local removedBlocks = {}

local function update()
	zone.Position = root.Position
	detectedBlocks, removedBlocks = VoxelSystem.detectVoxelBlock(zone, "VoxelBlock", detectedBlocks)
	for _, block: Part in ipairs(detectedBlocks) do
		if not table.find(removedBlocks, block) then
			block.Transparency = 1
		end
	end
	
	for _, block in ipairs(removedBlocks) do
		block.Transparency = 0
	end
end

RunService.RenderStepped:Connect(update)
