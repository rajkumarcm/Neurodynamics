function CIJ = rewire_network( CIJ, exc_neurons , p )

 N = size(CIJ,1);
 for i = 1:N
     for j = 1:N
         if CIJ(i,j) && rand < p
             CIJ(i,j) = 0;
             m = randi([1,8]);
             min_lim = ((m-1)*exc_neurons)+1;
             max_lim = m*exc_neurons;
             h = randi([min_lim max_lim]);
             CIJ(i,h) = 1;
             CIJ(h,i) = 0;
         end
     end
 end

%     for i = 1:N
%        for j = i+1:N
%           if CIJ(i,j) && rand < p
%              %display(sprintf('Node selected: ( %d,%d )',i,j));
%              CIJ(i,j) = 0;
%              CIJ(j,i) = 0;
%              h = mod(i+ceil(rand*(N-1))-1,N)+1;
%              CIJ(i,h) = 1;
%              CIJ(h,i) = 1;
%           else
%               %display(sprintf('Node unselected: ( %d,%d )',i,j));
%           end
%        end
%     end
end