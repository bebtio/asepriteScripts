local dlg = Dialog{ title = "Generate Midpoint color"}

dlg:color {
    id = "clr1",
    label = "Color1: ",
    color = Color(0xffff7f00)
}

dlg:color {
    id = "clr2",
    label = "Color2: ",
    color = Color(0xffff7f00)
}


dlg:combobox{ id="midpointType",
              label="Midpoint Type",
              option="SquareRoot",
              options={ "SquareRoot", "linear" },
              onchange={}
}

dlg:color {
    id = "result",
    label = "Result: ",
    color = Color(0xffff7f00)
}

dlg:button {
    id="computeBtn",
    text="Compute",

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

        dlg:modify{
            id = "result",
            color = newColor
        }
    end
}


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