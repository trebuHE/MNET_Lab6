%
% This computes the flux of cars
% for a given car density (in [# of vehicles/km])
%
function val = flux(rho)

  global u_max;
  global rho_max;
  val = rho*u_max*(1-rho/rho_max);
  
end
