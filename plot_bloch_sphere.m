function plot_bloch_sphere(t,rho)
% PLOT_BLOCH_SPHERE    Plots a Bloch sphere for the two-level system.
%
% In:       t          num(1,:)     Time points [µs]  
%           rho        num(4,:)     Density matrix elements at each point t [dimless]
%
% Author:   T P Ogden <t.p.ogden@durham.ac.uk>
%
% Notes:    Outputs plotted_bloch_sphere.pdf

u = (rho(:,3) + rho(:,2));

v = (rho(:,3) - rho(:,2))./1i;

w = (rho(:,1) - rho(:,4));


[x,y,z] = sphere(20);
figure
mesh(x,y,z,'EdgeColor',[0.8 0.8 0.8],'LineWidth',0.25)
axis equal
xlabel('u')
ylabel('v')
zlabel('w')
alpha(.3)
hidden off
grid off

hold on
plot3(real(u),real(v),real(w),'r','LineWidth',2)

print('-painters','-dpdf','-r300','pdf/plotted_bloch_sphere.pdf')

end