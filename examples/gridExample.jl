
import Pkg
Pkg.add([
	"WGPUgfx", 
	"WGPUCore", 
	"WGPUCanvas", 
	"GLFW", 
	"Rotations", 
	"StaticArrays", 
	"WGPUNative",
])

using WGPUgfx
using WGPUCore
using GLFW
using GLFW: WindowShouldClose, PollEvents, DestroyWindow
using LinearAlgebra
using Rotations
using StaticArrays

WGPUCore.SetLogLevel(WGPUCore.WGPULogLevel_Off)

grid = defaultGrid()

scene = Scene()
canvas = scene.canvas

renderer = getRenderer(scene)

addObject!(renderer, grid)
attachEventSystem(renderer)

function runApp(renderer)
	init(renderer)
	render(renderer)
	deinit(renderer)
end

main = () -> begin
	try
		while !WindowShouldClose(canvas.windowRef[])
			runApp(renderer)
			PollEvents()
		end
	finally
		WGPUCore.destroyWindow(canvas)
	end
end

if abspath(PROGRAM_FILE)==@__FILE__
	main()
else
	main()
end
