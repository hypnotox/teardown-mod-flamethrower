Knob = {
    nozzleDegree = 30,
    nozzleDegreeMin = 10,
    nozzleDegreeMax = 90,
}

function Knob:update()
    tool = GetToolBody()

    shapes = GetBodyShapes(tool)
    knobShape = shapes[2]
    -- DrawShapeOutline(knobShape, 255, 255, 0, 1)

    if InputPressed('usetool') then
        SetShapeEmissiveScale(knobShape, 100)
    end

    knobBody = GetShapeBody(knobShape)
    DrawBodyOutline(knobBody,255,0,0,0.8)

    if InputDown('q') then
        
    end
end