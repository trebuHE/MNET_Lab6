%
% This computes the numerical flux 
% for the Godunov scheme, associated
% with the flux of cars. The car densities
% at the two boundaries (at points i, and i+1)
% equal rho_i and r_i_plus_1.
%
function val = numflux(rho_i, rho_i_plus_1)
  
  global rho_max;
  rho_crit = rho_max / 2;

  if (rho_i <= rho_crit && rho_i_plus_1 <= rho_crit)

      val = flux(rho_i);

  elseif (rho_i <= rho_crit && rho_i_plus_1 > rho_crit)

      val = min(flux(rho_i), flux(rho_i_plus_1));

  elseif (rho_i > rho_crit && rho_i_plus_1 <= rho_crit)

      val = flux(rho_crit);
  else
      val = flux(rho_i_plus_1);
  end

end
