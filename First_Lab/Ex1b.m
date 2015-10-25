function Ex1b

dt1 = 0.1; % large step size
dt2 = 0.01; % smaller step size
% Time points
Tmin = 0;
Tmax = 100;

T2 = Tmin:dt1:Tmax;
T3 = Tmin:dt2:Tmax;

m = 1;
c = 0.1;
k = 1;

% % Euler method with large step size

v(1) = 1;
v2(1) = 0;

 for t = 1:length(T2)-1
    v(t+1) = v(t)+dt1*v2(t);
    f = -(1/m)*((c*v2(t))+(k*v(t)));
    v2(t+1) = v2(t)+(dt1*f);
 end

figure
plot(T2,v,'Color','Blue')
ylim([-1 1]);
 
% Euler method with smaller step size

z(1) = 1;
w(1) = 0;

for t = 1:length(T3)-1

   z ( t+1 ) = z(t) + ( dt2 * w(t) );
   w ( t+1 ) = w(t) + ( dt2 * ( -1/m * ( ( c * w(t) ) + ( k * z(t) ) ) ) ); 

end

figure
plot(T3,z,'Color','Red')
ylim([-1 1]);

end