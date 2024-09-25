cd C:/GSEA-P-R/Bow/sig_pathways_abs/U87_vs_U87Gdrad24hr

files = dir('selected_pathway_c5.3_go_bp.txt');
n = length(files);
    for i=(1:n)
        files(i).name=erase(files(i).name,".txt");
        newname=sprintf('%s.gmt',files(i).name);
        oldname=sprintf('%s.txt',files(i).name);
        movefile(oldname,newname);
        
    end
    
    