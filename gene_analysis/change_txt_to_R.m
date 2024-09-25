cd C:/GSEA-P-R/Bow/Run/norm/U87_vs_U87rad24hr

files = dir('*.txt');
n = length(files);
    for i=(1:n)
        files(i).name=erase(files(i).name,".txt");
        newname=sprintf('%s.R',files(i).name);
        oldname=sprintf('%s.txt',files(i).name);
        movefile(oldname,newname);
        
    end
    
    