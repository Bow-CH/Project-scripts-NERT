
cd C:\Users\Bow\Desktop\PhD\GSEA_microarray\sig_results_Reem_data
filename='sig_pathways_c5_go_bp_cut_off';


[num_data,txt_data,raw_data] = xlsread(filename);
data_dim=size(txt_data);
total_row=data_dim(1);

data=txt_data(1:total_row,1);
[row,col]=size(data);
row_index=[];

cd C:\Users\Bow\Desktop\PhD\GSEA_microarray\database
database='c5.go.bp.v2023.2.Hs.symbols.xlsx';
%%% call out the list of significant pathway %%%
[num_path,txt_path,raw_path] = xlsread(database);


for i=(2:row)
    %%% start from 2 excluding heading, if there is no heading, put 1 instead

    locate_index=strcmpi(data{i}, txt_path(:,1));
    row_index=[row_index,find(locate_index==1)];
end

% number of file to split into > can only run 60 pathways at a time for norm
number_files=fix((length(row_index)-1)/60);
for j=(1:number_files)
sig_pathways=txt_path(row_index(1+(60*(j-1)):60*j),:);
save sig_pathways

%%% only for Matlab version 2019 or later %%%
cd C:\Users\Bow\Desktop\PhD\GSEA_microarray\sig_results_Reem_data\sig_c5_go_bp

writecell(sig_pathways,sprintf('%d.txt',j),'Delimiter','\t');
newname=sprintf('selected_pathway_%d.gmt',j);
oldname=sprintf('%d.txt',j);
movefile(oldname,newname);
end

% last set that less than 60
if mod(length(row_index)-1,60) >0
    sig_pathways=txt_path(row_index((60*number_files)+1:length(row_index)),:);
    save sig_pathways
    
    writecell(sig_pathways,sprintf('last_file.txt'),'Delimiter','\t');
    newname=sprintf('selected_pathway_last_file.gmt');
    oldname=sprintf('last_file.txt');
    movefile(oldname,newname);
else
end

clear



