// A function is used for dragging and moving splittable elements.
// Adapted from https://stackoverflow.com/questions/46044589/dynamically-resize-columns-in-css-grid-layout-with-mouse/53731196#53731196
function dragElement(element, direction)
{
    var   md; // remember mouse down info
    const first  = document.getElementById("splitter-before");
    const second = document.getElementById("splitter-after");

    element.onmousedown = onMouseDown;

    function onMouseDown(e)
    {
        //console.log("mouse down: " + e.clientX);
        md = {e,
              offsetLeft:  element.offsetLeft,
              offsetTop:   element.offsetTop,
              firstWidth:  first.offsetWidth,
              secondWidth: second.offsetWidth
             };

        document.onmousemove = onMouseMove;
        document.onmouseup = () => {
            //console.log("mouse up");
            document.onmousemove = document.onmouseup = null;
        }
    }

    function onMouseMove(e)
    {
        //console.log("mouse move: " + e.clientX);
        var delta = {x: e.clientX - md.e.clientX,
                     y: e.clientY - md.e.clientY};

        if (direction === "H" ) // Horizontal
        {
            // Prevent negative-sized elements
            delta.x = Math.min(Math.max(delta.x, -md.firstWidth),
                       md.secondWidth);

            element.style.left = md.offsetLeft + delta.x + "px";
            first.style.width = (md.firstWidth + delta.x) + "px";
            second.style.width = (md.secondWidth - delta.x) + "px";
        }
    }
}


// dragElement( document.getElementById("splitter-separator"), "H" );
