function display_depth(z)
    surfl(fliplr(z),[0 90])
    shading flat
    axis equal
    view(130,30)
    colormap gray
    camlight headlight
    camlight(0,90)
    axis off
end
