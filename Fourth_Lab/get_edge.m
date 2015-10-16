function edge_val = get_edge( expected_degree )
    for edge_val = 1:20 % Replace this 20 to maximum possible combinations
        CIJ = NetworkWattsStrogatz(100,edge_val,0);
        count = 0;
        for p = 1:size(CIJ,1)
            for q = 1:size(CIJ,2)
                if p~=q && q>p && CIJ(p,q)==1
                  count = count+1;
                end
            end
        end
        if count==expected_degree
            break;
        end
     end