--------------- VOXEL SYSTEM 1.0 ---------------
--> ModuleScript

local module = {}

function module.setupVoxel(part: Part, voxelResolution: number?, createModel: boolean?, tag: string?)
	local model

	if voxelResolution == nil then
		voxelResolution = 1
	end

	if createModel == true then
		model = Instance.new("Model")
		model.Parent = part.Parent
		model.Name = part.Name
	end

	-- Setup blocks
	local size_x = part.Size.X / voxelResolution
	local size_y = part.Size.Y / voxelResolution
	local size_z = part.Size.Z / voxelResolution

	local block = part:Clone()
	block.Size = Vector3.new(voxelResolution, voxelResolution, voxelResolution)
	block.Anchored = true
	
	if tag then
		block:AddTag(tag)
	end

	for x=1, size_x do
		for y=1, size_y do
			for z=1, size_z do
				local blockClone = block:Clone()
				blockClone.Position = part.Position + Vector3.new(
					-part.Size.X/2 + (x - 0.5) * voxelResolution,
					((-part.Size.Y/2) + part.Size.Y/2) + (y - 1) * voxelResolution,
					-part.Size.Z/2 + (z - 0.5) * voxelResolution
				)
			
				if model ~= nil then
					blockClone.Parent = model
				end
			end
		end
	end
end

function module.detectVoxelBlock(collider: Part, blockTag: string, detectedBlocksMem: {Part?})
	-- Variables
	local detectedBlocks = {}
	local tempDetectedBlocks = {}
	local removedBlocks = {}
	local blocks = workspace:GetPartsInPart(collider)

	for _, block in ipairs(blocks) do
		if block:HasTag(blockTag) then
			table.insert(tempDetectedBlocks, block)
		end
	end
	
	if detectedBlocksMem then
		for _, block: Part in ipairs(detectedBlocksMem) do
			if not table.find(tempDetectedBlocks, block) then
				-- This runs when the collision ends
				table.insert(removedBlocks, block)
			end
		end
	end

	detectedBlocks = table.clone(tempDetectedBlocks)
	return detectedBlocks, removedBlocks
end

return module
