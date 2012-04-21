function [center] = centroid(inimage)

[xpos, ypos, val] = find(inimage);

mom(1,1) = sum(val);

if (mom(1,1) == 0)
  center = [0 0];
  return;
end

x0 = sum(xpos.*val)/mom(1,1);
y0 = sum(ypos.*val)/mom(1,1);

center = [x0 y0];