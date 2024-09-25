function [list_S,list_SD,masking,TR]=signal_intensity(file,masking,counting)
% This function is for finding the signal intensities and their standard
% deviations of ROI areas
% INPUTS
%   file:       the file stored data from MR scan
%
%   masking:    call the masking function, use {} if masking has not been defined
%
%   counting:   the order of file running. If counting is 1, the dimension of
%               image reading will be shown on screen so that the user can confirm the 
%               dimension before running the rest of the code. Also the
%               masking input will be required, if counting is 1.
%
% OUTPUTS
%   list_S:     return cells of 7 sub-cells for each concentration, each
%               sub-cell contains the mean signal intensities of all 
%               measurements at different time e.g. list_S{1} will return
%               the signal intensities of water at different time
%
%   list_SD:    return cells of 7 sub-cells for each concentration, each
%               sub-cell contains the standard deviation of signal intensities 
%               of all measurements at different time 
%
%   masking:    the masking defined (this will be useful if there are more
%               than one file running at a time, same masking will be
%               applied to all)
%               
%                             
% download an image data, the folder needs to be changed if run by
% different machine
[im,info]=BrukerReadImage(sprintf('C:\Users\Bow\Desktop\PhD\calibration_data\%g',file));
image_size=size(im); % dimension of an image

% only for the first file of each set, check the dimemsion of the file
% before performing anything
    if counting==1
        disp(image_size)
        confirm=input('Is this the dimension that you want? (Y/N)');
            if confirm == 'N'
                error('The dimension expected is (x,y,t,slice)');
            end
    end
    
    % open the image to prepare for masking
    %%%%% might need to change this, check image size first !!! %%%%%
    image=imagesc(im(:,:,1,30));
    
    % masking only the first image of the set, the other images using the
    % same mask as we assume that there is a small vibration so that the
    % position of samples should not significantly change
    if isempty(masking)==1
        masking=image_masking(image);
    end

    % Preallocation
    S_water=zeros(1,image_size(4)); 
    S_1=zeros(1,image_size(4)); 
    S_2=zeros(1,image_size(4)); 
    S_3=zeros(1,image_size(4)); 
    S_4=zeros(1,image_size(4)); 
    S_5=zeros(1,image_size(4)); 
    S_6=zeros(1,image_size(4)); 
    S_7=zeros(1,image_size(4));
    S_8=zeros(1,image_size(4)); 
    S_9=zeros(1,image_size(4)); 
    S_10=zeros(1,image_size(4)); 
    S_11=zeros(1,image_size(4)); 
    
    
    SD_water=zeros(1,image_size(4)); 
    SD_1=zeros(1,image_size(4)); 
    SD_2=zeros(1,image_size(4)); 
    SD_3=zeros(1,image_size(4)); 
    SD_4=zeros(1,image_size(4)); 
    SD_5=zeros(1,image_size(4)); 
    SD_6=zeros(1,image_size(4)); 
    SD_7=zeros(1,image_size(4));
    SD_8=zeros(1,image_size(4)); 
    SD_9=zeros(1,image_size(4)); 
    SD_10=zeros(1,image_size(4)); 
    SD_11=zeros(1,image_size(4)); 
    
    
    for i=(1:image_size(4))
        original_im=im(:,:,1,i); % take the image data of each frame (slice 2)
        mask_image_water=original_im.*(masking{1});
        mask_image_1=original_im.*(masking{2});
        mask_image_2=original_im.*(masking{3});
        mask_image_3=original_im.*(masking{4});
        mask_image_4=original_im.*(masking{5});
        mask_image_5=original_im.*(masking{6});
        mask_image_6=original_im.*(masking{7});
        mask_image_7=original_im.*(masking{8});
        mask_image_8=original_im.*(masking{9});
        mask_image_9=original_im.*(masking{10});
        mask_image_10=original_im.*(masking{11});
        mask_image_11=original_im.*(masking{12});
        
        % find the mean signal intensities of the masking area (excluding zero)
        S_water(i)=mean(mask_image_water(mask_image_water>0)); 
        S_1(i)=mean(mask_image_1(mask_image_1>0));
        S_2(i)=mean(mask_image_2(mask_image_2>0));
        S_3(i)=mean(mask_image_3(mask_image_3>0));
        S_4(i)=mean(mask_image_4(mask_image_4>0));
        S_5(i)=mean(mask_image_5(mask_image_5>0));
        S_6(i)=mean(mask_image_6(mask_image_6>0));
        S_7(i)=mean(mask_image_7(mask_image_7>0));
        S_8(i)=mean(mask_image_8(mask_image_8>0));
        S_9(i)=mean(mask_image_9(mask_image_9>0));
        S_10(i)=mean(mask_image_10(mask_image_10>0));
        S_11(i)=mean(mask_image_11(mask_image_11>0));
        
        
        
        % find the standard deviation of the signal intensities in the masking area (excluding zero)
        SD_water(i)=std(mask_image_water(mask_image_water>0)); 
        SD_1(i)=std(mask_image_1(mask_image_1>0));
        SD_2(i)=std(mask_image_2(mask_image_2>0));
        SD_3(i)=std(mask_image_3(mask_image_3>0));
        SD_4(i)=std(mask_image_4(mask_image_4>0));
        SD_5(i)=std(mask_image_5(mask_image_5>0));
        SD_6(i)=std(mask_image_6(mask_image_6>0));
        SD_7(i)=std(mask_image_7(mask_image_7>0));
        SD_8(i)=std(mask_image_8(mask_image_8>0));
        SD_9(i)=std(mask_image_9(mask_image_9>0));
        SD_10(i)=std(mask_image_10(mask_image_10>0));
        SD_11(i)=std(mask_image_11(mask_image_11>0));
        
    end
    
    % store data in the list, ready to be called
    list_S={S_water,S_1,S_2,S_3,S_4,S_5,S_6,S_7,S_8,S_9,S_10,S_11};
    list_SD={SD_water,SD_1,SD_2,SD_3,SD_4,SD_5,SD_6,SD_7,SD_8,SD_9,SD_10,SD_11};
    TR=info.PVM.MultiRepTime;
end