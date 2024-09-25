%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% DIRECTORY %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% ***Please update the directory before running the code***%%%

% Folder where the codes including the codes for functions are stored
directory_code='C:\Users\Bow\Desktop\PhD\run_fluorescent_analysis';

% Folder where the images that will be analysed are stored
directory_im='C:\Users\Bow\Desktop\PhD\compare_image_analysis_method\NP_image';

% Folder where the masks are stored
directory_mask='C:\Users\Bow\Desktop\PhD\compare_image_analysis_method\mask';

% Folder where the Background masks are stored
directory_bg='C:\Users\Bow\Desktop\PhD\compare_image_analysis_method\mask';


%%%%%%%%%%%%%%%%%%%%%%
%%% INPUT REQUIRED %%%
%%%%%%%%%%%%%%%%%%%%%%
step_point=20; % every xth point around the edge
step_line=20; % every xx along the line
calibration=1; %if the scale of image was already calibrated

% -------------------------
full_output=struct;
over_all_max_intensity=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The list containing all the image files inside the image folder
cd(directory_im)
call_im_files=dir('*.tif'); 
image={call_im_files.name}; % Add image file names to the list
% The list containing all the mask files inside the mask folder
cd(directory_mask)
call_mask_files=dir('*.tif'); 
mask={call_mask_files.name}; % Add mask file names to the list
% The list containing all the background mask files inside the mask folder
cd(directory_bg)
call_bg_files=dir('*.tif'); 
bg={call_bg_files.name}; % Add background mask file names to the list


for file_number=(1:length(image))
    cd(directory_code)
    [inner_spheroid_masking]=spheroid_mask_smoother(directory_mask,mask{file_number},step_point);
    
    cd(directory_code)
    [intensity_profile, linear_eqn]=intensity_profile_individual(inner_spheroid_masking,directory_im,directory_bg,image{file_number},bg{file_number},step_line,calibration);
    
    cd(directory_code)
    [output]=average_intensity_profile(intensity_profile);

    % max intensity for narmalisation
    max_intensity=max(output.max_intensity);

    if max_intensity > over_all_max_intensity
        over_all_max_intensity=max_intensity;
    end
    
    % Save figures
    saveas(figure(1),sprintf('apply_mask_%s',image{file_number}))
    saveas(figure(2),sprintf('intensity_profile_%s',image{file_number}))
    % Export output data to excel file
    writetable(struct2table(output), sprintf('output_file_%s.xlsx',image{file_number}))
    % Export output data to matlab file
    full_output.file{file_number}=output;
    % Clear some parameters
    clearvars -except directory_code directory_im directory_mask image mask step_point step_line full_output calibration over_all_max_intensity directory_bg bg
    % Clear figures
    clf
end
disp(over_all_max_intensity)

