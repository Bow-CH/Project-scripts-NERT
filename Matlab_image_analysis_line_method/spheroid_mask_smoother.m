function [inner_spheroid_masking]=spheroid_mask_smoother(directory,filename,step)
%{
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Parameters explanation %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT
% - directory is directory where we keep the masking image.
% - filename is the filename of the mask we are working on.
% - step is the interval of the points around the edge that we will
consider 
%
% OUTPUT
% Structure array of inner_spheroid_masking contains information of 
% - edge coordinates
% - inner masking centre
% - masking minor and major axes
% - select_index (depending on the step we put in the input)
% - rho and theta (on polar coordinate)
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Find centre of the spheroid %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load inner mask
cd(directory)
%inner_mask_original=imbinarize(imread(filename));
inner_mask=imbinarize(imread(filename));
% Inverse the value for the mask 
%inner_mask=imcomplement(inner_mask_original);

% Detect centre of mass of each object in the image
centres=regionprops(inner_mask,'centroid','MajorAxisLength','MinorAxisLength','Image');

% Find the centre of the main spheroid
list_objects=[centres(:).MajorAxisLength];
idx_centre_spheroid=find(list_objects==max(list_objects));
centroids=cat(1,centres.Centroid);

% Call x-y coordinate of centroid of the main spheroid in the original
% image
x_centre=centroids(idx_centre_spheroid,1);
y_centre=centroids(idx_centre_spheroid,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Create a mask for ROI that will mask only main spheroid %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% !! The ROI mask will not have the same size as the original image !!
% We need to rescale the image

% Call the mask of the ROI - main spheroid 
mask_ROI=centres(idx_centre_spheroid).Image;
% Call the centroid coordinates in the ROI mask
centre_ROI=regionprops(mask_ROI,'centroid');

% Translate the x-y coordinate of the centroid in ROI mask to map 
% the centroid coordinates of the original image
translation=[x_centre y_centre]-(centre_ROI.Centroid);
tform = randomAffine2d("XTranslation",[translation(1) translation(1)],"YTranslation",[translation(2) translation(2)]);
% Keep the size to be the same size as the original image
followOutput=affineOutputView(size(inner_mask),tform);
% Do the translation
new_mask=imwarp(mask_ROI,tform,"OutputView",followOutput);

%imshow(new_mask); - can use to check the mask whether it is correct

%%%%%%%%%%%%%%%%%%%%%%
%%% Blur the edges %%%
%%%%%%%%%%%%%%%%%%%%%%

windowSize = 30; % adjust window size depending on how blurry we want (higher is blurier)
kernel = ones(windowSize) / windowSize ^ 2;
blurryImage = conv2(single(new_mask), kernel, 'same');
binaryImage = blurryImage > 0.5; % Rethreshold
Edges = bwmorph(binaryImage, 'remove'); %Perform morphological operations on binary images
[edge_x_mask, edge_y_mask] = find(Edges');

% Shift the origin - move the spheroid centre to point (0,0)
edge_x_mask_shift=edge_x_mask-x_centre;
edge_y_mask_shift=edge_y_mask-y_centre;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Choose the coordinates of x and y edge from the polar coordinate, take
%%% one angle every set step (depends on the input) %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[theta,rho] = cart2pol(edge_x_mask_shift,edge_y_mask_shift);
% theta from [-pi, pi]

[theta_sorted,sort_idx] = sort(theta);
take_index=sort_idx(1:step:end);

% Extra information
rho_select=rho(take_index);
theta_select=theta(take_index);
major_axis=centres(idx_centre_spheroid).MajorAxisLength;
minor_axis=centres(idx_centre_spheroid).MinorAxisLength;

%%%%%%%%%%%%
%%% Plot %%%
%%%%%%%%%%%%
imshow(inner_mask)
hold on
% Plot spheroid centre
plot(x_centre,y_centre,'b*')
% Plot the masking edge
plot(edge_x_mask,edge_y_mask,'b.')
% Plot selected points
plot(edge_x_mask(take_index),edge_y_mask(take_index),'r*')

hold off


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Store output in inner_spheroid_masking parameter %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
inner_spheroid_masking.edgeX=edge_x_mask;
inner_spheroid_masking.edgeY=edge_y_mask;
inner_spheroid_masking.centre=[x_centre y_centre];
inner_spheroid_masking.MajorAxis=major_axis;
inner_spheroid_masking.MinorAxis=minor_axis;
inner_spheroid_masking.select_index=take_index;
inner_spheroid_masking.rho=rho_select;
inner_spheroid_masking.theta=theta_select;

end



