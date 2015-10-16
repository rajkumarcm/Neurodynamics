function ge = global_efficiency( CIJ )
 N = size(CIJ,1);
 [~,dis] = breadthdist(CIJ);
 pl_acc = 0;
 for i = 1:N
     for j = 1:N
         if i ~= j && ( j > i )
             pl_acc = pl_acc + 1/dis(i,j);
         end
     end
 end
 ge = pl_acc/N*(N-1);
end