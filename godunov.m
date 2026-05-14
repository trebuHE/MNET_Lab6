%
% This script uses Godunov scheme to 
% simulate the traffic flow problem
%

clear all

global rho_max;
global u_max;

%
% problem parameters
%
rho_max=200.0
u_max=60.0
rho_L=200.0

%
% we will consider x in range [-2,2], and t in range [0,2]
%
T=4/60;
XL=-2;
XR=2;

%
% discretization
%
delta_x = 4/400
delta_t = 0.8*delta_x/u_max

delt_by_delx = delta_t/delta_x;

xs = XL:delta_x:XR;
ts = 0:delta_t:T;
Nx = length(xs);
Nt = length(ts);
rho = zeros(Nt,Nx);

%
% put your initial conditions here
%



%
% a few sample trajectories 
%

traj(1,:) = [-1.0 -1.0 -1.0];
Ntraj = length(traj);

for n=2:Nt
    
  % incoming flux at x = XL  
  flux_minus = numflux(rho(n-1,1), rho(n-1,1));  
    
  for i=1:Nx

    % compute discrete fluxes F(xi-1/2) and F(xi+1/2)
    % assume the disturbance never reaches the domain boundaries
    % Note: F(xi-1/2) is taken from the previous step of the loop

    rho_i = rho(n-1, i);

    if (i==Nx)
      rho_i_plus_1 = rho_i;
    else
      rho_i_plus_1 = rho(n-1,i+1);
    end

    flux_plus = numflux(rho_i, rho_i_plus_1);

    %
    % add code to model periodic red light
    %
    


    %
    % compute the density
    %    
    rho(n,i)=rho(n-1,i)-delt_by_delx*(flux_plus-flux_minus);

    % save flux for the previous x
    flux_minus = flux_plus;
    
  end

  %
  % compute the sample trajectories, fix the code below!
  %
  
%  for j=1:Ntraj
%    traj(n,j) = interpolate_rho(traj(n-1,j), rho(n-1,:), xs);
%  end

end



