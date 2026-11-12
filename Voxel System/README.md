# Voxel System 1.0

A modular voxel system for Roblox, written in Luau.

Voxel System allows you to transform a regular `Part` into multiple smaller blocks (voxels) and detect which voxels are interacting with a specific collider.

The module is designed to be flexible, allowing developers to create their own mechanics and interactions instead of relying on predefined behaviors.

## Features

- Transform Parts into smaller voxels.
- Customizable voxel resolution.
- Optional Model creation to organize the generated blocks.
- Optional CollectionService tags for voxel identification.
- Collision detection between voxels and a collider.
- Detection of blocks that are no longer colliding.
- Flexible API for creating custom mechanics.

## Installation

1. Download `VoxelSystem.luau`.
2. Insert it into your Roblox project as a `ModuleScript`.
3. Require the module in your script.

```lua
local VoxelSystem = require(path.to.VoxelSystem)
```

## Functions

### `setupVoxel(part, voxelResolution?, createModel?, tag?)`

Transforms a Part into multiple smaller blocks.

**Parameters:**

| Parameter | Type | Required |
|---|---|---|
| `part` | Part | Yes |
| `voxelResolution` | number | No |
| `createModel` | boolean | No |
| `tag` | string | No |

#### `part`

The reference Part used to generate the voxels.

The generated blocks inherit the original Part's properties.

#### `voxelResolution`

Defines the size of each generated voxel, in studs.

- Default: `1`
- Must be greater than `0`.
- Smaller values generate more, smaller voxels.
- Larger values generate fewer, larger voxels.

**Performance considerations:**

Voxel count increases significantly as the resolution decreases.

For example, using a resolution of `0.1` generates 1,000 voxels for every cubic stud of volume.

Choose a resolution according to the size of the reference Part and the performance requirements of your game.

Very small resolutions are not recommended for large Parts.

**Important:** The resolution must be smaller than all three dimensions of the reference Part (`Size.X`, `Size.Y` and `Size.Z`). Otherwise, some dimensions may not generate any voxels.

For a complete and uniform subdivision, it is also recommended that the dimensions of the Part are divisible by the chosen resolution.

#### `createModel`

Defines whether the generated voxels will be organized inside a Model.

- Default: `nil` (`false`).
- `true`: Creates a Model containing the generated voxels.
- `false` or `nil`: Does not create a Model.

The Model inherits the name of the reference Part and is placed under the same parent.

#### `tag`

Defines a CollectionService tag assigned to all generated voxels.

- Type: `string`
- Optional.

This is especially useful when working with `detectVoxelBlock`, since the tag allows the function to identify which blocks should be detected.

---

### `detectVoxelBlock(collider, blockTag, detectedBlocksMem)`

Detects voxels currently intersecting a collider and identifies blocks that are no longer colliding.

**Parameters:**

| Parameter | Type | Required |
|---|---|---|
| `collider` | Part | Yes |
| `blockTag` | string | Yes |
| `detectedBlocksMem` | table | No |

#### `collider`

The Part used as the collision detector.

The function checks which voxels are currently inside or intersecting this Part.

#### `blockTag`

The CollectionService tag used to identify the voxels that should be detected.

Only Parts containing this tag will be included in the results.

#### `detectedBlocksMem`

A table containing the blocks detected during the previous call.

This parameter allows the function to identify blocks that have stopped colliding with the collider.

It is optional, but necessary if you want to detect when a collision ends.

See the [Examples](#examples) section for a practical demonstration.

**Returns:**

The function returns two tables:

1. `detectedBlocks`: Contains all currently detected voxels.
2. `removedBlocks`: Contains voxels that were detected previously but are no longer detected.

The first returned table should be stored and passed back as `detectedBlocksMem` on the next call.

---

## Examples

The following example demonstrates how to use the module to create a snow interaction system.

[SnowExample.luau](https://github.com/TUDIBR/Luau-Codes/blob/45cf8cf0b1317f7c27d96b6ddd56e421e37ea884/Voxel%20System/Examples/SnowExample.luau)

The example also demonstrates the use of `detectedBlocksMem` to identify when a voxel stops colliding with the collider.

## Possible Applications

Voxel System provides a foundation for many different mechanics, including:

- **Snow deformation:** Create footprints and trails that gradually disappear.
- **Dynamic walls:** Make walls appear or disappear when players approach.
- **Terrain excavation:** Remove voxels as players move through an object.
- **Destruction:** Create holes and craters using explosions.
- **Custom interactions:** Build your own mechanics using the detection results.

These are just a few possibilities. The module does not restrict developers to predefined interactions.

## Performance

Performance depends heavily on the reference Part's size and the chosen voxel resolution.

Generating too many voxels can cause significant performance problems, including execution timeouts.

Consider the following when using the module:

- Avoid unnecessarily small voxel resolutions.
- Be careful when generating voxels for large Parts.
- Avoid generating excessive amounts of voxels simultaneously.
- Test different resolutions to find a suitable balance between visual quality and performance.

## License

See the repository's license for usage and distribution permissions.
