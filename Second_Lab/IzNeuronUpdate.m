function layer = IzNeuronUpdate(layer,i,t,Dmax)
% Updates membrane potential v and reset rate u for neurons in layer i
% using Izhikevich's neuron model and the Euler method. Dmax is the maximum
% conduction delay

% Note. In case you are confused what is the difference between Dmax and
% delays stored in the `delay` matrix of a layer.

dt = 0.2; % Euler method step size
% Calculate current from incoming spikes
for j=1:length(layer)
   S = layer{i}.S{j};
   if ~isempty(S)
      firings = layer{j}.firings;
      if ~isempty(firings)
         % Find incoming spikes (taking account of propagation delays)
         delay = layer{i}.delay{j};
         F = layer{i}.factor{j};
         % Sum current from incoming spikes
         k = size(firings,1);
         while (k>0 && firings(k,1)>t-(Dmax+1))
             % delay(:, firings(k,2)) - get all delays of the k-th neuron,
             % to neurons in the subsequent layer
             
             % firings(k,1) - time when k-th neuron fired
             % t - firings(k,1) - how much time passed since k-th neuron
             % fired and current time step `t`
             
             % vector of neurons to which k-th neuron is connected and
             % supposed to receive a spike, because the time finally came.
            spikes = (delay(:,firings(k,2))==t-firings(k,1));
            if ~isempty(layer{i}.I(spikes))
                % S - connections matrix
                % S(spikes,firings(k,2)) - neurons which connected to k-th
                % and should receive a spike
                % S(spikes,firings(k,2))*F - incrase base current of
                % neurons which supposed to receive a spike, from one of
                % the neurons in j-th layer
               layer{i}.I(spikes) = layer{i}.I(spikes)+S(spikes,firings(k,2))*F;
            end
            k = k-1;
         end;
         % Don't let I go below zero (shunting inhibition)
         % layer{i}.I = layer{i}.I.*(layer{i}.I > 0);
      end
   end
end
% Update v and u using Izhikevich's model in increments of dt
for k=1:1/dt
   v = layer{i}.v;
   u = layer{i}.u;
   layer{i}.v = v+(dt*(0.04*v.^2+5*v+140-u+layer{i}.I));
   layer{i}.u = u+(dt*(layer{i}.a.*(layer{i}.b.*v-u)));
   % Reset neurons that have spiked
   fired = find(layer{i}.v>=30); % indices of spikes
   if ~isempty(fired)
      layer{i}.firings = [layer{i}.firings ; t+0*fired, fired];
      layer{i}.v(fired) = layer{i}.c(fired);
      layer{i}.u(fired) = layer{i}.u(fired)+layer{i}.d(fired);
   end
end