%
% This script uses Godunov scheme to 
% simulate the traffic flow problem
%

clear all

global u_max;
global rho_max;

%
% problem parameters
%
rho_max=200.0
u_max=60.0
rho_L=200.0

rho_R = 20

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

for i = 1:Nx
    if xs(i) <= 0
        rho(1, i) = rho_max;
    else
        rho(1, i) = rho_R;
    end
end


%
% a few sample trajectories 
%

traj(1,:) = [-1.5 -1.0 -0.5];
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

  for j=1:Ntraj
    % find local density at car position using interpolation 
    rho_at_car = interpolate_rho(traj(n-1,j), rho(n-1,:), xs);
    
    % Euler forward step 
    speed = u_max * (1 - rho_at_car / rho_max);
    traj(n,j) = traj(n-1,j) + delta_t * speed;
  end

end

figure(1);
[XX, YY] = meshgrid(xs, ts);
pcolor(XX, YY, rho);
shading('interp');
colorbar;
xlabel('Position x [km]');
ylabel('Time t [h]');
title('Traffic Density Evolution');

hold on
plot(traj, ts, 'w', 'LineWidth', 1.5);
hold off

