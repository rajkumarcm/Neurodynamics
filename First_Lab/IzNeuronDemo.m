%----------------------------------------------------
% Name: Rajkumar Conjeevaram Mohan
% Email: Rajkumar.Conjeevaram-Mohan14@imperial.ac.uk
% File Name: IzNeuronDemo.m
%----------------------------------------------------

dt = 0.2;
T = 1:dt:200;
I = 10; % Base ( Dendritic ) current.

%---- Excitatory Neuron Dynamics
% a = 0.02;
% b = 0.2;
% c = -65;
% d = 8;

%---- Inhibitory Neuron Dynamics
%a = 0.02;
%b = 0.25;
%c = -65;
%d = 2;

%---- Bursting Neuron Dynamics
a = 0.02;
b = 0.25;
c = -55;
d = 0;
T = 1:dt:1000;
I = 0.8;

THRESHOLD = 30;

v(1) = -65;
u(1) = -1;

for t = 1:length(T)-1
    v(t+1) = v(t) + dt*( 0.04*v(t)^2 + 5*v(t) + 140 - u(t) + I );
    u(t+1) = u(t) + dt*( a*( b*v(t) - u(t) ) );
    
    if v(t+1) >= THRESHOLD
        %v(t) = dirac(v(t));
        v(t) = 30;
        v(t+1) = c;
        u(t+1) = u(t+1)+d;
    end
end

subplot(3,1,[1,2]);
plot(T, v);
%xlim([0 200]);

subplot(3,1,3);
plot(T, u);
%xlim([0 200]);