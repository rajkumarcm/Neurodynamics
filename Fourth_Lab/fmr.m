function fmr_m = fmr( firings1, Tmax )
    f_m = cell(8,1);
    for m = 1:8 % 9 modules in total
        % Now, filter according to population (1:8)
        si = ((m-1)*100)+1;
        ei = m*100;
        if ~isempty(firings1)
            indices_gn = firings1(:,2)>=si;
            indices_st = firings1(:,2)<=ei;
            indices_pt = indices_gn==indices_st;
            f_m{m,1} = firings1(indices_pt,:);
        end
    end

    % So far firings have been classified as per modules
    % Now, the firings rates are downsampled every 20ms

    % For now, lets calculate the firing rate for the first
    % module alone
    temp = [];
    %ds_t = downsample(unique(f_m{1}(:,1)),50); % f_m{1} -> 1 represents nth module
    fmr_m = cell(8,1);
    for m = 1:8
       temp = [];
       sample = f_m{m,1};
       for t = 0:20:Tmax-20    
            % var sample has the downsampled data
            % Indices for next 50ms®
            indices1 = sample(:,1) >= t;
            indices2 = sample(:,1) < t+50;
            indices = indices1==indices2;
            if sum(sample(indices)) > 1
                neurons_fired = length(sample(indices,2));
                avg = neurons_fired/50;
                if t == 0
                    display('catch me');
                end
                temp = [ temp; t avg ];
            else
                temp = [ temp; t 0 ];
            end
       end
       fmr_m{m} = temp;
    end
    
end