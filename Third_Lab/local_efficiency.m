function le = local_efficiency( CIJ)
 % This function computes the local efficiency of a network, which
 % is represented by connectivity matrix CIJ, and takes N node as input
 le = 0;
 for i = 1:size(CIJ,1)
     sub_CIJ = adjacent_cm(CIJ,i);
     le = le + global_efficiency(sub_CIJ);
 end
 le = le/size(CIJ,1);
 
end

function ad_cm = adjacent_cm( CIJ, N )
 x = find(CIJ(N,:)~=0);
 ad_cm = zeros(length(x),length(x));
 for i = 1:length(x)
     for j = 1:length(x)
        if i~=j
          ad_cm(i,j) = CIJ(x(i),x(j));
        end
     end
  end
end