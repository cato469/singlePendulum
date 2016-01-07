function out=ode_singlePendulumFwd(t,state,sys)
dim = size(state);
if dim(2) ==1
    state = state';
end;
l = sys.l;
d = sys.d;
m = sys.m;
g = sys.g;
I = sys.I;

Fx = zeros(length(t));
Fy = zeros(length(t));
for i = 1:length(t)
    cphi = cos(state(i,1));
    sphi = sin(state(i,1));
    ddt_phi = state(i,2);
    
    % x = d*cphi;
    % y = d*sphi;
    % xd = -d*sphi*dphi;
    % yd = d*cphi*dphi;
    
    
    
    %equations of motion are:
%       ddt_phi    Fx       Fy
    A = [-m*d*sphi -1        0; % F =m*ddt(X) 
          m*d*cphi  0       -1; % F =m*ddt(Y) 
          I     -d*sphi d*cphi];% t =I*ddt(PHI)
    
    b = [m*d*cphi*ddt_phi^2;
        m*g + m*d*sphi*ddt_phi^2
        0];
    
    sol = A\b;
    
    stated(1) = state(2);
    stated(2) = sol(1);
    Fx(i) = sol(2);
    Fy(i) = sol(3);
end;

out.stated = stated(:);
out.phi = state(:,1);
out.dphi = state(:,2);
out.Fx =Fx;
out.Fy = Fy;
out.x = d*cos(state(:,1));
out.y = d*sin(state(:,1));
out.dx = -d*sin(state(:,1)).*ddt_phi;
out.dy = d*cos(state(:,1)).*ddt_phi;
