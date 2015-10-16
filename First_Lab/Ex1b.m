function Ex1b

%dt1 = 0.5; % large step size
dt2 = 0.01; % smaller step size
% Time points
Tmin = 0;
Tmax = 100;

%T2 = Tmin:dt1:Tmax;
T3 = Tmin:dt2:Tmax;

m = 1;
c = 0.1;
k = 1;

% % Euler method with large step size
% y2(1) = 1;
% for t = 2:length(T2)
%    y2(t) = -(1/m)*(c*(0+(k*y2(t-1))));
%    y2(t) = y2(t-1)+(dt1*y2(t));
% end
% Euler method with smaller step size

z(1) = 1;
w(1) = 0;

for t = 1:length(T3)-1
    
   %w( t+1 ) = w(t) + ( dt2 * t * ( -w(t) + sin( t * z(t) ) ) );
   %z( t+1 ) = z(t) + ( dt2 * t * w(t) );
   
   z ( t+1 ) = z(t) + ( dt2 * w(t) );
   w ( t+1 ) = w(t) + ( dt2 * ( -1/m * ( ( c * w(t) ) + ( k * z(t) ) ) ) ); 
   
   %y3(t) = (-1/m)*((c*0)+(k*y3(t-1)));
   %y3(t) = y3(t-1)+(dt2*y3(t));
end

plot(T3,z,'Color','Red')
ylim([-1 1]);

end