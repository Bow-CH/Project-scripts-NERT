function BrukerCine2nii(slicelist,fn)
% BRUKERCINE2NII converts a list of Bruker scans to a nifty 4d file
%           SLICELIST is the list of scans, use 'E' number. e.g. [166 167
%           ...]. Slices can be in any order
%           FN is the file name of nifty file. Please add the extension .nii 
%slicelist = [166:-1:162 155:161]; % top slice to bottom slice
%fn = 'm1_20171004.nii';
ns = length(slicelist);
[im info] = BrukerReadImage(['./' num2str(slicelist(1))]);
slicepos = zeros([ns 1]); 
cardiac4d = zeros([size(im,1) size(im,2) ns size(im,3)]);
for idx=1:ns
    [im info] = BrukerReadImage(['./' num2str(slicelist(idx))]);
    cardiac4d(:,:,idx,:) = im;
    slicepos(idx) = info.PVM.SliceOffset;
end

% reorder slices to actual slice order
[dummy slorder] = sort(slicepos);
cardiac4d = cardiac4d(:,:,slorder,:);


res3 = [info.PVM.SpatResol info.PVM.SliceThick];
c4dnii = make_nii(cardiac4d,res3);
save_nii(c4dnii,fn);
end
