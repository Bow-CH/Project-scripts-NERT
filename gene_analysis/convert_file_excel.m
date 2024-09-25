%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Call text files from norm folder then export them to folder
%%% frequency_new in xlsx format 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cd C:/GSEA-P-R/Bow/Results/U87_vs_U87Gdrad30min/norm/c5_go_bp/
%cd C:/GSEA-P-R/Bow/Results/U87rad24hr_vs_U87Gdrad24hr/norm/c5_go_bp_U87Gdrad24hr
%folders=dir(); %%% comment this line out if it is single folder selection

%for n=(3:size(folders))
    %cd (folders(n).name) %%% comment this line out if it is single folder selection
    files = dir('*.txt');
    a = length(files); %%% change to n if it is single file selection
    %to one folder in the directory

    for i=(1:a)
        %%% for single folder selection %%%
        %%%cd C:/GSEA-P-R/Bow/Results/U87rad24hr_vs_U87Gdrad24hr/norm/c5_go_bp_U87Gdrad24hr
        
        cd C:/GSEA-P-R/Bow/Results/U87_vs_U87Gdrad30min/norm/c5_go_bp/ %comment this line out if it is single folder selection
        %cd (folders(n).name)
        thisfile=files(i).name;
        data=readtable(thisfile);
        name_title=regexprep(thisfile,'\<txt\>','xlsx');
        
        cd C:/GSEA-P-R/Bow/Results/U87_vs_U87Gdrad30min/frequency_change_CER
        %cd (folders(n).name)
        %%% for single folder selection %%%
        %%%writetable(data,replace(thisfile,'txt','xlsx'));
        writetable(data,sprintf('%s',name_title));

    end
    clear 
    %%% comment these two lines out if it is single folder selection
    %cd cd C:/GSEA-P-R/Bow/Results/U87rad24hr_vs_U87Gdrad24hr/norm/c5.2_go_bp
    %folders=dir();
    
%end