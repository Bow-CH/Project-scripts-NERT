 cd 'C:/GSEA-P-R/Bow/Results/'
 folder={'U87_vs_U87GdNPs','U87_vs_U87rad24hr','U87_vs_U87rad30min','U87Gdrad30min_vs_U87Gdrad24hr','U87rad24hr_vs_U87Gdrad24hr','U87rad30min_vs_U87Gdrad30min'};
 
 for comparison_set=(1:1)
    cd 'C:/GSEA-P-R/Bow/Results/'
    cd(folder{comparison_set})
    cd frequency_new
    file_name_all=dir();
    for i=(3:size(file_name_all))
        file_name=a(i).name;
        [num_data,txt_data,raw_data] = xlsread(file_name);
        max_val=max(num_data(:,7));
        min_val=min(num_data(:,7));
        index_max=find(max_val==num_data(:,7));
        index_min=find(min_val==num_data(:,7));
        %%num_data exclude heading, hence when refer to index in raw_data 
        %%needs to plus 1
        if index_max(1)<index_min(1)
            index_max=index_max(1);
            index_min=index_min(end);
        else
            index_max=index_max(end);
            index_min=index_min(1);
        end
        
        if index_max<index_min
            raw_data(2:index_max+1,8)={'YES'};
            raw_data(index_min+1:end,8)={'YES'};
        else
            raw_data(2:index_min+1,8)={'YES'};
            raw_data(index_max+1:end,8)={'YES'};
        end
        writecell(raw_data,file_name);
    end
 end
 
        
    
    