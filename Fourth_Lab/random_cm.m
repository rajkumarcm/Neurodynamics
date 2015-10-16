function sample_cm = random_cm(N, d)

    sample_cm = zeros(N,N);
    neuron_ns = 1:N;
    network_degree = d;
    degree = ceil(network_degree/N);
    for i = 1:N
        ran_neurons = randi([min(neuron_ns) max(neuron_ns)],1,degree);

        % Check whether ran_neurons are already connected in
        % reverse direction
        for neuron = 1:length(ran_neurons)
            load_count = 0;
            while true
                if sample_cm(ran_neurons(neuron),i)==1 || ...
                                i==ran_neurons(neuron) ||...
                                sum(ran_neurons == ran_neurons(neuron))~=1
                    
                    new_neuron = randi([min(neuron_ns) max(neuron_ns)],1,1);
                    ran_neurons(neuron) = new_neuron;
                    if load_count >= 1000
                        display('CPU load is high...');
                        break;
                    end
                else
                    break;
                end
                load_count = load_count+1;
            end
        end
        sample_cm(i,ran_neurons)=1;
    end
end

% function count = count_connection( sample_cm )
%     % Count the number of uni direction connections established in cm
% 
%     count = sum(sample_cm(1,:));
%     for i = 2:5
%         for j = 1:5
%             if i~=j && sample_cm(j,i)==0 && sample_cm(i,j)==1
%                 count = count+1;
%             end
%         end
%     end
% end