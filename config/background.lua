require 'cairo'

-- Main drawing function called by Conky
function conky_draw_bg()
    if conky_window == nil then return end
    
    -- Initialize Cairo surface
    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    local cr = cairo_create(cs)
    
    local width = conky_window.width
    local height = conky_window.height
    local radius = 20  
    
    -- Define background color and alpha
    -- Values are R, G, B, Alpha (0.0 to 1.0)
    -- This matches dark gray (#242424) at 55% opacity
    local r, g, b, a = 0.14, 0.14, 0.14, 0.55
    
    -- CREATE THE ROUNDED RECTANGLE PATH
    cairo_move_to(cr, radius, 0)
    cairo_line_to(cr, width - radius, 0)
    cairo_arc(cr, width - radius, radius, radius, -math.pi/2, 0)
    cairo_line_to(cr, width, height - radius)
    cairo_arc(cr, width - radius, height - radius, radius, 0, math.pi/2)
    cairo_line_to(cr, radius, height)
    cairo_arc(cr, radius, height - radius, radius, math.pi/2, math.pi)
    cairo_line_to(cr, 0, radius)
    cairo_arc(cr, radius, radius, radius, math.pi, -math.pi/2)
    cairo_close_path(cr)
    
    -- Fill the defined path with color
    cairo_set_source_rgba(cr, r, g, b, a)
    cairo_fill(cr)
    
    -- Clean up Cairo resources
    cairo_destroy(cr)
    cairo_surface_destroy(cs)
end