%----------------------------------------------------
% Name: Rajkumar Conjeevaram Mohan
% Email: Rajkumar.Conjeevaram-Mohan14@imperial.ac.uk
% File Name: HH_Euler.m
%----------------------------------------------------

function HH_Euler
    
    dt = 0.05;
    Tmin = 1;
    Tmax = 100;
    T = Tmin:dt:Tmax;
    
    g_na = 120;
    g_k = 36;
    g_l = 0.3;
    
    e_na = 115;
    e_k = -12;
    e_l = 10.6;
    
    I = 10; % Base (Dendritic) current
    
    v(1) = -10;
    m = 0;
    n = 0;
    h = 0;
    
    for t = 1:length(T)-1
        
        dm_alpha = (2.5-0.1*v(t))/(exp(2.5-0.1*v(t))-1);
        dm_beta = 4*exp(-v(t)/18);
        dm =  dm_alpha* (1-m) -dm_beta * m;
        m = m + dt*dm;
        
        dn_alpha = (0.1-0.01*v(t))/(exp(1-0.1*v(t))-1);
        dn_beta = 0.125*exp(-v(t)/80);
        dn = dn_alpha*(1-n)-dn_beta*n;
        n = n + dt*dn;
        
        dh_alpha = 0.07*exp(-v(t)/20);
        dh_beta = 1/(exp(3-0.1*v(t))+1);
        dh = dh_alpha*(1-h)-dh_beta*h;
        h = h + dt*dh;
        
        i_k = g_na*m^3*h*(v(t)-e_na)+g_k*n^4*(v(t)-e_k)+g_l*(v(t)-e_l);
        v(t+1) = v(t) + dt*(-i_k+I);
        
    end
    plot(T,v);
end