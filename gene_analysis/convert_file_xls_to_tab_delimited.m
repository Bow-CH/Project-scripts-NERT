cd C:/GSEA-P-R/Bow/Results/U87_vs_U87Gdrad30min/frequency_change_CER/
%folders=dir();
%for folder_number=(3:size(folders))
    %cd C:/GSEA-P-R/Bow/Results/U87_vs_U87rad24hr/frequency_change_CER/
    %folders=dir();
    %cd (folders(folder_number).name)
    files = dir('*.xls');
    n = length(files);
    for i=(1:n)
        cd C:/GSEA-P-R/Bow/Results/U87_vs_U87Gdrad30min/frequency_change_CER/
        %cd (folders(folder_number).name)
        thisfile=files(i).name;
        data=readtable(thisfile);
        name_title=regexprep(thisfile,'\<txt\>','xls');
        writetable(data,sprintf('%s.txt',name_title),'Delimiter','\t');
        newname=sprintf('%s',name_title);
        oldname=sprintf('%s.txt',name_title);
        movefile(oldname,newname);

    end
%end

     