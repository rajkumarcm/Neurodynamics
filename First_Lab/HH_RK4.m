%----------------------------------------------------
% Name: Rajkumar Conjeevaram Mohan
% Email: Rajkumar.Conjeevaram-Mohan14@imperial.ac.uk
% File Name: HH_RK4.m
%----------------------------------------------------

function HH_RK4

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
        dm =  dm_alpha*(1-m) -dm_beta * m;
        m1 = dm;
        m2 = dm + dt * 0.5 * m1;
        m3 = dm + dt * 0.5 * m2;
        m4 = dm + dt * m3;
        m =  m + dt *((m1+2*m2+2*m3+m4)/6);
        
        dn_alpha = (0.1-0.01*v(t))/(exp(1-0.1*v(t))-1);
        dn_beta = 0.125*exp(-v(t)/80);
        dn = dn_alpha*(1-n)-dn_beta*n;
        n1 = dn;
        n2 = dn + dt * 0.5 * n1;
        n3 = dn + dt * 0.5 * n2;
        n4 = dn + dt * n3;
        n =  n + dt *((n1+2*n2+2*n3+n4)/6);
        
        dh_alpha = 0.07*exp(-v(t)/20);
        dh_beta = 1/(exp(3-0.1*v(t))+1);
        dh = dh_alpha*(1-h)-dh_beta*h;
        h1 = dh;
        h2 = dh + dt * 0.5 * h1;
        h3 = dh + dt * 0.5 * h2;
        h4 = dh + dt * h3;
        h =  h + dt *((h1+2*h2+2*h3+h4)/6);
        
        i_k = g_na*m^3*h*(v(t)-e_na)+g_k*n^4*(v(t)-e_k)+g_l*(v(t)-e_l);
        i_k = -i_k+I;
        v1 = i_k;
        v2 = i_k + dt * 0.5 * v1;
        v3 = i_k + dt * 0.5 * v2;
        v4 = i_k + dt * v3;
        v(t+1) = v(t) + dt * (( v1+2*v2+2*v3+v4 )/6);
    end
 plot(T, v);
end