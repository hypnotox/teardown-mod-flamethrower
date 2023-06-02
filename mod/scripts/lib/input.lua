function initInput()
    Input = {}

    -- Physical

    ---@return string Escape key
    function Input.esc()
        return 'esc'
    end

    ---@return string Tab key
    function Input.tab()
        return 'tab'
    end

    ---@return string Left mouse button
    function Input.lmb()
        return 'lmb'
    end

    ---@return string Right mouse button
    function Input.rmb()
        return 'rmb'
    end

    ---@return string Middle mouse button
    function Input.mmb()
        return 'mmb'
    end

    ---@return string Up arrow key
    function Input.upArrow()
        return 'uparrow'
    end

    ---@return string Down arrow key
    function Input.downArrow()
        return 'downarrow'
    end

    ---@return string Left arrow key
    function Input.leftArrow()
        return 'leftarrow'
    end

    ---@return string Right arrow key
    function Input.rightArrow()
        return 'rightarrow'
    end

    ---@return string Function keys
    function Input.f1()
        return 'f1'
    end

    ---@return string Function keys
    function Input.f2()
        return 'f2'
    end

    ---@return string Function keys
    function Input.f3()
        return 'f3'
    end

    ---@return string Function keys
    function Input.f4()
        return 'f4'
    end

    ---@return string Function keys
    function Input.f5()
        return 'f5'
    end

    ---@return string Function keys
    function Input.f6()
        return 'f6'
    end

    ---@return string Function keys
    function Input.f7()
        return 'f7'
    end

    ---@return string Function keys
    function Input.f8()
        return 'f8'
    end

    ---@return string Function keys
    function Input.f9()
        return 'f9'
    end

    ---@return string Function keys
    function Input.f10()
        return 'f10'
    end

    ---@return string Function keys
    function Input.f11()
        return 'f11'
    end

    ---@return string Function keys
    function Input.f12()
        return 'f12'
    end

    ---@return string Backspace key
    function Input.backspace()
        return 'backspace'
    end

    ---@return string Alt key
    function Input.alt()
        return 'alt'
    end

    ---@return string Delete key
    function Input.delete()
        return 'delete'
    end

    ---@return string Home key
    function Input.home()
        return 'home'
    end

    ---@return string End key
    function Input.endKey()
        return 'end'
    end

    ---@return string PgUp key
    function Input.pgUp()
        return 'pgup'
    end

    ---@return string PgDown key
    function Input.pgDown()
        return 'pgdown'
    end

    ---@return string Insert key
    function Input.insert()
        return 'insert'
    end

    ---@return string Space bar
    function Input.space()
        return 'space'
    end

    ---@return string Shift key
    function Input.shift()
        return 'shift'
    end

    ---@return string Ctrl key
    function Input.ctrl()
        return 'ctrl'
    end

    ---@return string Return key
    function Input.returnKey()
        return 'return'
    end

    ---@return string Any key or button
    function Input.any()
        return 'any'
    end

    ---@return string Mouse horizontal diff. Only valid in InputValue.
    function Input.mouseDx()
        return 'mousedx'
    end

    ---@return string Mouse vertical diff. Only valid in InputValue.
    function Input.mouseDy()
        return 'mousedy'
    end

    ---@return string Mouse wheel. Only valid in InputValue.
    function Input.mousewheel()
        return 'mousewheel'
    end

    -- Logical

    ---@return string Move forward / Accelerate
    function Input.up()
        return 'up'
    end

    ---@return string Move backward / Brake
    function Input.down()
        return 'down'
    end

    ---@return string Move left
    function Input.left()
        return 'left'
    end

    ---@return string Move right
    function Input.right()
        return 'right'
    end

    ---@return string Interact
    function Input.interact()
        return 'interact'
    end

    ---@return string Flashlight
    function Input.flashlight()
        return 'flashlight'
    end

    ---@return string Jump
    function Input.jump()
        return 'jump'
    end

    ---@return string Crouch
    function Input.crouch()
        return 'crouch'
    end

    ---@return string Use tool
    function Input.usetool()
        return 'usetool'
    end

    ---@return string Grab
    function Input.grab()
        return 'grab'
    end

    ---@return string Handbrake
    function Input.handbrake()
        return 'handbrake'
    end

    ---@return string Map
    function Input.map()
        return 'map'
    end

    ---@return string Pause game (escape)
    function Input.pause()
        return 'pause'
    end

    ---@return string Camera x movement, scaled by sensitivity. Only valid in InputValue.
    function Input.cameraX()
        return 'cameraX'
    end

    ---@return string Camera y movement, scaled by sensitivity. Only valid in InputValue.
    function Input.cameraY()
        return 'cameraY'
    end
end