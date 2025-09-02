-- Small script to compute the midpoint color between two colors.
-- Can use various methods.
-- Currently implemented methods
--   SquareRoot
--   Linear
--
-- Future Todos:
--  - Add drop down for difference color spaces and compute midpoints from there.
local dlg = Dialog{ title = "Generate Midpoint Color"}

dlg:button {
    id="refreshBtn",
    text="Refresh Input Colors",
    onclick=function()
        dlg:modify{ id="clr1", color=app.fgColor }
        dlg:modify{ id="clr2", color=app.bgColor }
    end
}

dlg:color {
    id = "clr1",
    label = "Color1: ",
    color = app.fgColor
}

dlg:button {
    id = "clr1Btn",
    text = "Set Pencil To Color",
    onclick = function()
        app.fgColor = dlg.data.clr1
    end
}

dlg:color {
    id = "clr2",
    label = "Color2: ",
    color = app.bgColor
}

dlg:button {
    id = "clr2Btn",
    text = "Set Pencil To Color",
    onclick = function()
        app.fgColor = dlg.data.clr2
    end
}

dlg:combobox{ id="midpointType",
              label="Midpoint Type",
              option="SquareRoot",
              options={ "SquareRoot", "linear" },
              onchange={}
}


dlg:button {
    id="computeBtn",
    text="Compute",

    -- Computes the modpoint of two colors based on which method is chosen and the
    -- current colors selected by clr1 and clr2 Color widgets.
    onclick=function()
        local data = dlg.data
        local selectedOption = data.midpointType

        local c1 = data.clr1
        local c2 = data.clr2
        local newColor

        if selectedOption == "SquareRoot" then
            newColor = midPointSqrt(c1,c2)
        elseif selectedOption == "linear" then
            newColor = midPointLinear(c1,c2)
        else
            app.alert("NOT A VALID OPTION... HOW DID YOU GET HERE?")
        end

        app.fgColor = newColor
        dlg:modify{id = "result", color=newColor }
    end
}

dlg:color {
    id = "result",
    label = "Result: ",
    color = Color(0xffff7f00)
}

dlg:button {
    id= "resultBtn",
    text = "Set Pencil to Color",
    onclick = function ()
        app.fgColor = dlg.data.result
    end
}

-- Functions for midpoint computation. These will be called by the computeBtn widget.
function midPointSqrt( c1, c2 )

    local red   = math.sqrt(((c1.red   * c1.red   + c2.red   * c2.red)  /2.0))
    local green = math.sqrt(((c1.green * c1.green + c2.green * c2.green)/2.0))
    local blue  = math.sqrt(((c1.blue  * c1.blue  + c2.blue  * c2.blue) /2.0))

    return Color{r=red, g=green, b=blue, a=255}

end

function midPointLinear( c1, c2 )

    local red   = ( c1.red   + c2.red   ) / 2.0
    local green = ( c1.green + c2.green ) / 2.0
    local blue  = ( c1.blue  + c2.blue  ) / 2.0

    return Color{r=red, g=green, b=blue, a=255}
end

dlg:show{wait = false}