function Run2L
% Simulates two layers (imported from saved file) of Izhikevich neurons

clear;
load('Network.mat','layers');
for l = 1:length(layers)
    layer = layers{l};
    N1 = layer{1}.rows;
    M1 = layer{1}.columns;

    N2 = layer{2}.rows;
    M2 = layer{2}.columns;

    Dmax = 20; % maximum propagation delay

    Tmax = 1000; % simulation time - CHANGED TO 1000MS

    Ib = 5; % base current % CHECK THIS


    % Initialise layers
    for lr=1:length(layer)
       layer{lr}.v = -65*ones(layer{lr}.rows,layer{lr}.columns);
       layer{lr}.u = layer{lr}.b.*layer{lr}.v;
       layer{lr}.firings = [];
    end


    % SIMULATE

    for t = 1:Tmax

       % Display time every 10ms
       if mod(t,10) == 0
          clc
          percentage = ceil((t/Tmax)*100);
          display(sprintf('%d%%',percentage));
       end

       % Deliver a constant base current to layer 1
       % Small amount of background firing to prevent
       % activation from dying out. When poisson process
       % produces value above 0, extra current I=15, is
       % injected.

       layer{1}.I = zeros(N1,M1) + (poissrnd(0.01,N1,M1)*15);
       layer{2}.I = zeros(N2,M2);

       % For each ms, IZNeurons of all layers are updated
       for lr=1:length(layer)
          layer = IzNeuronUpdate(layer,lr,t,Dmax);
       end

       v1(t,1:N1*M1) = layer{1}.v;
       v2(t,1:N2*M2) = layer{2}.v;

       u1(t,1:N1*M1) = layer{1}.u;
       u2(t,1:N2*M2) = layer{2}.u;

    end


    firings1 = layer{1}.firings;
    firings2 = layer{2}.firings;

    % Add Dirac pulses (mainly for presentation)
    if ~isempty(firings1)
       v1(sub2ind(size(v1),firings1(:,1),firings1(:,2))) = 30;
    end
    if ~isempty(firings2)
       v2(sub2ind(size(v2),firings2(:,1),firings2(:,2))) = 30;
    end

    % Raster plots of firings

    figure
    clf

    subplot(2,1,1)
    if ~isempty(firings1)
       plot(firings1(:,1),firings1(:,2),'.', ...
                                        'Color','Blue',...
                                        'MarkerSize',11)
    end
    % xlabel('Time (ms)')
    prob = 0:.1:.5;
    xlim([0 Tmax])
    ylabel('Neuron number')
    ylim([0 N1*M1+1])
    set(gca,'YDir','reverse')
    title(sprintf('Population 1 firings P - %f',prob(l)))

%     subplot(2,1,2)
%     if ~isempty(firings2)
%        plot(firings2(:,1),firings2(:,2),'.')
%     end
%     xlabel('Time (ms)')
%     xlim([0 Tmax])
%     ylabel('Neuron number')
%     ylim([0 N2*M2+1])
%     set(gca,'YDir','reverse')
%     title('Population 2 firings')
    fmr_m = fmr( firings1, Tmax );
    subplot(2,1,2)
    if ~isempty(fmr_m)
        for m = 1:size(fmr_m,1)
            temp = fmr_m{m};
            plot(temp(:,1),temp(:,2));
            hold on;
        end
        xlabel('Time (ms)');
        ylabel('Mean firing rate');
        title('Mean firing rate of Excitatory Neurons');
    end
    drawnow    
end