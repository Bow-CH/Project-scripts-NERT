cd C:/GSEA-P-R/Bow/Results/U87rad30min_vs_U87Gdrad30min/frequency_new/
%folders=dir();

    files = dir('*.xls');
    n = length(files);
    for i=(133)
        cd C:/GSEA-P-R/Bow/Results/U87rad30min_vs_U87Gdrad30min/frequency_new/
        
        thisfile=files(i).name;
        data=readtable(thisfile);
        name_title=regexprep(thisfile,'\<txt\>','xls');
        writetable(data,sprintf('%s.txt',name_title),'Delimiter','\t');
        newname=sprintf('%s',name_title);
        oldname=sprintf('%s.txt',name_title);
        movefile(oldname,newname);

    end
     