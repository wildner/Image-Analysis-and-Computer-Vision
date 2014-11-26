% adapted from
% http://www.ece.northwestern.edu/local-apps/matlabhelp/techdoc/visualize/chvolvi7.html

function volume_visualize( x, y, z, v )

    % Determine the range of the volume by finding the minimum and maximum of the coordinate data.
    xmin = min(x(:)); 
    ymin = min(y(:)); 
    zmin = min(z(:));

    xmax = max(x(:)); 
    ymax = max(y(:)); 
    zmax = max(z(:));

    % Create a Slice Plane at an Angle to the X-Axes
    % To create a slice plane that does not lie in an axes plane, first define a surface and rotate it to the desired orientation. This example uses a surface that has the same x and y coordinates as the volume.
    hslice = surf(linspace(xmin,xmax,100),...
        linspace(ymin,ymax,100),...
        zeros(100));

    % Rotate the surface by -90 degrees about the x axis and save the surface XData, YData, and ZData to define the slice plane; then delete the surface.
    rotate(hslice,[-1,0,0],-90)
    %rotate(hslice,[0,0,1],-45)
    xd = get(hslice,'XData');
    yd = get(hslice,'YData');
    zd = get(hslice,'ZData');
    delete(hslice)
    
    
    % Test a second slice plane for fun
    hslice = surf(linspace(xmin,xmax,100),...
        linspace(ymin,ymax,100),...
        zeros(100));

    % Rotate the surface by -90 degrees about the x axis and save the surface XData, YData, and ZData to define the slice plane; then delete the surface.
    rotate(hslice,[-1,0,0],-90)
    rotate(hslice,[0,0,1],-90)
    xd2 = get(hslice,'XData');
    yd2 = get(hslice,'YData');
    zd2 = get(hslice,'ZData');
    delete(hslice)

    % Draw the Slice Planes
    % Draw the rotated slice plane, setting the FaceColor to interp so that it is colored by the figure colormap and set the EdgeColor to none. Increase the DiffuseStrength to .8 to make this plane shine more brightly after adding a light source.

    h = slice(x,y,z,v,xd,yd,zd);
    set(h,'FaceColor','interp',...
        'EdgeColor','none',...
        'DiffuseStrength',1.0)

    hold on
    h2 = slice(x,y,z,v,xd2,yd2,zd2);
    set(h2,'FaceColor','interp',...
        'EdgeColor','none',...
        'DiffuseStrength',1.0)
    
    
    % Set hold to on and add three more orthogonal slice planes at xmax, ymax, and zmin to provide a context for the first plane, which slices through the volume at an angle.

    hx = slice(x,y,z,v,xmax,[],[]);
    set(hx,'FaceColor','interp','EdgeColor','none')

    hy = slice(x,y,z,v,[],ymax,[]);
    set(hy,'FaceColor','interp','EdgeColor','none')

    hz = slice(x,y,z,v,[],[],zmin);
    set(hz,'FaceColor','interp','EdgeColor','none')

    % Define the View
    % To display the volume in correct proportions, set the data aspect ratio to [1,1,1] (daspect). Adjust the axis to fit tightly around the volume (axis) and turn on the box to provide a sense of a 3-D object. The orientation of the axes can be selected initially using rotate3d to determine the best view.

    % Zooming in on the scene provides a larger view of the volume (camzoom). Selecting a projection type of perspective gives the rectangular solid more natural proportions than the default orthographic projection (camproj).

    daspect([1,1,1])
    axis tight
    box on
    view(-38.5,16)
    camzoom(1.4)
    camproj perspective

    % Add Lighting and Specify Colors
    % Adding a light to the scene makes the boundaries between the four slice planes more obvious since each plane forms a different angle with the light source (lightangle). Selecting a colormap with only 24 colors (the default is 64) creates visible gradations that help indicate the variation within the volume.

    lightangle(-45,45)
    %colormap (jet(24))
    set(gcf,'Renderer','zbuffer')
end
