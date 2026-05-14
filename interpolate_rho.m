%
% This finds an interpolated value of rho for a given x.
% To this end values of rho at gridpoints (xs) are used and
% linear interpolation is performed.
%
% x is the evaluation point
% rho is the array of rhos at gridpoints specified by array xs

function rho_out = interpolate_rho(x, rho, xs)

  Nx = length(xs);
  xmin = xs(1);
  xmax = xs(Nx);
  deltax = xs(2)-xs(1);
  
  % find the right range
  for i=1:Nx
    if x <= xs(i)
      break;
    end
  end

  rhoa = rho(i);
  if (i < Nx)
    rhob = rho(i+1);
  else
    rhob = rhoa;
  end

  %
  % do linear interpolation
  %
  rho_out = rhoa + (rhob-rhoa)*(x-xs(i))/deltax;
    
end
