function initEngine()
    -- Holds game engine constants
    Engine = {
        voxelSize = 0.05
    }

    function Engine:voxelCenterOffset()
        return Transform(Vec(Engine.voxelSize * 0.5, Engine.voxelSize * 0.5, -Engine.voxelSize * 0.5))
    end
end