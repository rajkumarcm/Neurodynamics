%----------------------------------------------------
% Name: Rajkumar Conjeevaram Mohan
% Email: Rajkumar.Conjeevaram-Mohan14@imperial.ac.uk
% File Name: IzNeuron_RK4.m
%----------------------------------------------------

function IzNeuron_RK4

dt = 0.5;
T = 1:dt:200;
I = 10; % Base ( Dendritic ) current.

%---- Excitatory Neuron Dynamics
% a = 0.02;
% b = 0.2;
% c = -65;
% d = 8;

%---- Inhibitory Neuron Dynamics
a = 0.02;
b = 0.25;
c = -65;
d = 2;

%---- Bursting Neuron Dynamics
% a = 0.02;
% b = 0.25;
% c = -55;
% d = 0;
% dt = 0.7;
% T = 1:dt:1000;
%  I = 0.8;

THRESHOLD = 30;

v_k(1) = -65;
u_k(1) = -1;

% v = 0.04*v(t)^2 + 5*v(t) + 140 - u(t) + I;
% u = a*( b*v(t) - u(t) );

for t = 1:length(T)-1
    %v(t+1) = v(t) + dt*( 0.04*v(t)^2 + 5*v(t) + 140 - u(t) + I );
    %u(t+1) = u(t) + dt*( a*( b*v(t) - u(t) ) );
    
%     v_k1 = v_k(t);
%     v_k2 = v_k(t) + 0.5 * dt * v_k1;
%     v_k3 = v_k(t) + 0.5 * dt * v_k2;
%     v_k4 = v_k(t) + dt * v_k3;
    v = (0.04*v_k(t)^2 + 5*v_k(t) + 140 - u_k(t) + I)
    v_k1 = v;
    v_k2 = v + 0.5 * dt * v_k1;
    v_k3 = v + 0.5 * dt * v_k2;
    v_k4 = v + dt * v_k3;
     
%     u_k1 = u_k(t);
%     u_k2 = u_k(t) + 0.5 * dt * u_k1;
%     u_k3 = u_k(t) + 0.5 * dt * u_k2;
%     u_k4 = u_k(t) + dt * u_k3;

    u = (a*( b*v_k(t) - u_k(t) ));

    u_k1 = u;
    u_k2 = u + 0.5 * dt * u_k1;
    u_k3 = u + 0.5 * dt * u_k2;
    u_k4 = u + dt * u_k3;

    %v_k(t+1) = v_k(t) + dt * (v_k1+v_k2+v_k3+v_k4)/6;
    %v_k(t+1) = (0.04*v_k(t)^2 + 5*v_k(t) + 140 - u_k(t) + I) ...
    %           + dt * (v_k1+v_k2+v_k3+v_k4)/6;
    v_k(t+1) = v_k(t) + dt * (v_k1+2*v_k2+2*v_k3+v_k4)/6;
    u_k(t+1) = u_k(t) + dt * (u_k1+2*u_k2+2*u_k3+u_k4)/6;
    
    if v_k(t+1) >= THRESHOLD
        v_k(t) = 30;
        v_k(t+1) = c;
        u_k(t+1) = u_k(t+1)+d;
    end
end

 subplot(3,1,[1,2]);
 plot(T, v_k);

 subplot(3,1,3);
 plot(T, u_k);
end