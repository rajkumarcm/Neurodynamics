function Connect2L
% Constructs two layers of Izhikevich neurons and connects them together

% Excitatory neuron layer
exc_modules = 8;
exc_neurons = 100; % per module
N1 = exc_modules*exc_neurons;
M1 = 1;

% Inhibitory neuron layer
N2 = 200;
M2 = 1;

expected_degree = 1000;
prob = 0:.1:.5;

% Neuron parameters
% Each layer comprises a heterogenous set of neurons, with a small spread
% of parameter values, so that they exhibit some dynamical variation
% (To get a homogenous population of canonical "regular spiking" neurons,
% multiply r by zero.)

% Layer 1 (regular spiking)
r = rand(N1,M1);
layer{1}.rows = N1;
layer{1}.columns = M1;
layer{1}.a = 0.02*ones(N1,M1);
layer{1}.b = 0.2*ones(N1,M1);
layer{1}.c = -65+15*r.^2;
layer{1}.d = 8-6*r.^2;

% Layer 2 (inhibitory spiking)
r = rand(N2,M2);
layer{2}.rows = N2;
layer{2}.columns = M2;
layer{2}.a = 0.02+0.08*r.*ones(N2,M2);
layer{2}.b = 0.25-0.05*r.*ones(N2,M2);
layer{2}.c = -65+15*r.^2;
layer{2}.d = 2*r.^2;

% Clear connectivity matrices
L = length(layer);
for i=1:L
   for j=1:L
      layer{i}.S{j} = [];
      layer{i}.factor{j} = [];
      layer{i}.delay{j} = [];
   end
end


%---------------------- Scaling Factor -----------------------------------

layer{1}.factor{1} = 17;
layer{1}.factor{2} = 2;
layer{2}.factor{1} = 50;
layer{2}.factor{2} = 1;

%---------------------- Delays -------------------------------------------
layer{1}.delay{1} = ones(N1*M1,N1*M1).*randi([1 20],N1*M1,N1*M1);
layer{1}.delay{2} = ones(N1*M1,N2*M2);
layer{2}.delay{1} = ones(N2*M2,N1*M1);
layer{2}.delay{2} = ones(N2*M2,N2*M2);

% ----------------- Connectivity Matrix Setup ----------------------------

% Connectivity matrix (synaptic weights)
% layer{i}.S{j} is the connectivity matrix from layer j to layer i
% s(i,j) is the strength of the connection from neuron j to neuron i



% Excitatory to Inhibitory neurons

cm = zeros(N2*M2,N1*M1);
n_inhneuron = 1;
for i = 1:4:(N1*M1)-5
    cm(n_inhneuron,i:i+3) = rand(1,4);
    n_inhneuron = n_inhneuron+1;
end

layer{2}.S{1} = cm;


% Each Inhibitory neuron connect to every neuron in the whole network

% Inhibitory to excitatory neurons
layer{1}.S{2} = (-1*rand(N1*M1,N2*M2)).*ones(N1*M1,N2*M2); % all to all connections

% Inhibitory to Inhibitory neurons
cm = zeros(N2*M2,N2*M2);
ran = -1*rand;
for i = 1:N2*M2
    for j = 1:N2*M2
        if i~=j && j>i
            cm(i,j) = -1*ran;
        end
    end
end
layer{2}.S{2} = cm';


% Excitatory to Excitatory neurons
% Edge of 20 per neuron would yield a total degree of 1000
% random directed connection.
% Role of probability comes here

cm = zeros(N1*M1,N1*M1);

for m = 1:exc_modules 
    temp_cm = random_cm(exc_neurons,expected_degree);
    si = ((m-1)*exc_neurons)+1;
    ei = m*exc_neurons;
    % Before assigning temp_cm to cm, do the rewiring
    cm(si:ei,si:ei) = temp_cm;
    
end
layer{1}.S{1} = cm;
layers = cell(length(prob),1);
for p = 1:length(prob)
    layers{p} = layer;
    layers{p}{1}.S{1} = rewire_network( layers{p}{1}.S{1}, ...
                                        exc_neurons, prob(p) );
end


save('Network.mat','layers');
