%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Change the value of Core Enrichment (the R code only gives one side) 
%%% We need both sides
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cd C:\Users\Bow\Desktop\Results_Bow\U87_vs_U87Gd\frequency_change_CER\all
 %folder={'U87_vs_U87GdNPs','U87_vs_U87rad24hr','U87_vs_U87rad30min','U87Gdrad30min_vs_U87Gdrad24hr','U87rad24hr_vs_U87Gdrad24hr','U87rad30min_vs_U87Gdrad30min'};

 %for comparison_set=(1:size(folder))
    %folder={'U87_vs_U87GdNPs','U87_vs_U87rad24hr','U87_vs_U87rad30min','U87Gdrad30min_vs_U87Gdrad24hr','U87rad24hr_vs_U87Gdrad24hr','U87rad30min_vs_U87Gdrad30min'};
    %cd 'C:/GSEA-P-R/Bow/Results/'
    %cd(folder{comparison_set})
    %cd frequency_new
    file_name_all=dir();
    for i=(3:size(file_name_all))
        %start from row 3, the first row are headings
        file_name=file_name_all(i).name;
        all_data(i).name=file_name;
        % all_data will be used to remember the index of the enriched genes

        [num_data,txt_data,raw_data] = xlsread(file_name);
        max_val=max(num_data(:,7));
        min_val=min(num_data(:,7));
        index_max=find(max_val==num_data(:,7));
        index_min=find(min_val==num_data(:,7));
        
        %%% In case there are multiple maximum values, we need to check
        %%% whether that value is on the left peak or the right peak from the
        %%% centre line
        %%% o if it is on the left, then we take the lower index
        %%% o if it is on the right, we will take the higher index
        
        if index_max(1)<index_min(1)
            index_max=index_max(1);
            index_min=index_min(end);
        else
            index_max=index_max(end);
            index_min=index_min(1);
        end
        
        %%% This will give another side by finding min and max value 
        %%% We need to find whether the max value is on the left or right side from
        %%% the centre line, 
        %%% o if it is on the left then the Core Enrichment of any 
        %%% index below the index of that max value will be converted to 'YES'
        %%% o if it is on the right then the Core Enrichment of any index above the
        %%% index of that max value will be converted to 'YES'
        %%% Vice versa for min value
        %%% num_data exclude heading, hence when refer to index in raw_data 
        %%% needs to plus 1
        
        if index_max<index_min
            raw_data(2:index_max+1,8)={'YES'};
            raw_data(index_min+1:end,8)={'YES'};
            all_data(i).index_pos=(2:index_max+1);
            all_data(i).genes_pos=raw_data(2:index_max+1,3);
            all_data(i).index_neg=(index_min+1:size(raw_data));
            all_data(i).genes_neg=raw_data(index_min+1:size(raw_data),3);
        else
            raw_data(2:index_min+1,8)={'YES'};
            raw_data(index_max+1:end,8)={'YES'};
            all_data(i).index_neg=(2:index_min+1);
            all_data(i).genes_neg=raw_data(2:index_min+1,3);
            all_data(i).index_pos=(index_max+1:size(raw_data));
            all_data(i).genes_pos=raw_data(index_max+1:size(raw_data),3);
        end
        writecell(raw_data,file_name);
        clearvars -except all_data
    end
    
 %end
 
        
    
    