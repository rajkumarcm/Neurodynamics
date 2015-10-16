%Author: Rajkumar Conjeevaram Mohan

N = 200;
E = 4;

P = 0.001:0.01:1;
SWI = zeros(length(P),1);
GE = zeros(length(P),1);
LE = zeros(length(P),1);

% For each network
for p = 1:length(P)
    CIJ = NetworkWattsStrogatz(N,E,P(1,p));
    SWI(p,1) = SmallWorldIndex(CIJ);
    GE(p,1) = global_efficiency(CIJ);
    LE(p,1) = local_efficiency(CIJ);
end

subplot(3,1,1)
semilogx(P,SWI,'x','Color','Red');
xlabel('Rewiring Probability');
ylabel('Small World Index');

subplot(3,1,2)
semilogx(P,GE,'x','Color','Blue');
xlabel('Rewiring Probability');
ylabel('Global Efficiency');

subplot(3,1,3)
semilogx(P,LE,'x','Color','Green');
xlabel('Rewiring Probability');
ylabel('Local Efficiency');
