function [intensity_profile, linear_eqn]=intensity_profile_individual(inner_spheroid_masking,directory_im,directory_bg,image_file,bg_mask,step,calibration)
%{
% UPDATE 23-07-2023: normalise intensity to brightess pixel of the image
set
% UPDATE 04-2023: measure distance from spheroid edge and take the distance
every xx um of the line
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Parameters explanation %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT
% - inner_spheroid_masking is the output from the function
%   spheroid_mask_smoother.
% - directory_im is the directory where we keep the images.
% - directory_mask is the directory where we keep the masks.
% - image_file is the filename of the image we are working on.
% - mask_file is the filename of the mask that we are working on 
%   -> In case of invasion study, this will be the invasion mask.
% - step is the input for intensity measurement frequency i.e. measuring
%   every x um along the line 
% - calibration is the calibration factor converting um to pixel (unit pixel/um)
%
% OUTPUT
% - Number_points is the total number of points along each line that we
%   considered
% Structure array of intensity_profile contains information of 
% - distance of points on the line to the inner edge for every lines that
%   we consider
% - intensity of the image that each point along the line passes through. 
% Structure array of linear_eqn contains information of 
% - m is the gradient of each line
% - c is the interception of each line
% 
%}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Call parameters from the results from spheroid_mask_smoother_function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Call all coordinates on spheroid edges
edge_x_mask=inner_spheroid_masking.edgeX;
edge_y_mask=inner_spheroid_masking.edgeY;
% Call the coordinates for centre of the spheroid
x_centre=inner_spheroid_masking.centre(1); 
y_centre=inner_spheroid_masking.centre(2);
% Call all the indexes of the points on the inner edge that we are taking
take_index=inner_spheroid_masking.select_index;

%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Define parameters %%%
%%%%%%%%%%%%%%%%%%%%%%%%%
linear_eqn=struct; % store linear equations of the fitting lines that pass through the two points of interest
intensity_profile=struct; % store intensity and distance information of every lines
x_edge=edge_x_mask(take_index); % list for x-coordinate of selected points on the spheroid edge
y_edge=edge_y_mask(take_index); % list for y-coordinate of selected points on the spheroid edge

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Apply masking on the image %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Call image
cd(directory_im)
I=imread(image_file);
apply_mask=I; %remove the apply mask on image because the edge from the previous step already contour the ROI

% Call background mask
cd(directory_bg)
im_bg_mask=imread(bg_mask);
bg_image=imbinarize(im_bg_mask);
% Inverse the value for the mask 
bg_inverse=imcomplement(bg_image);
% Apply background masking on the image
apply_bg = bsxfun(@times, I, cast(bg_inverse, 'like', I));
% calculate avaerage background
avg_bg=mean(apply_bg,'all');

% ------------------------------------------------------------------------
%%% OPTIONAL %%% 
% - can comment this part out to speed the code up
% To show image after a mask is applied
figure(1)
imshow(apply_mask)
hold on
plot(x_centre,y_centre,'b*')
% Plot selected points
plot(x_edge,y_edge,'r*')
% -------------------------------------------------------------------------

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Find linear equations in which each line passes through the point
%%% on spheroid edge and the spheroid centre. Find lines for every points
%%% on the inner edge (not just selected ones) %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

m=(y_edge-y_centre)./(x_edge-x_centre);
c=y_centre-(m.*x_centre);

% Store outputs in parameter linear_eqn (structure)
linear_eqn.m=m; % store gradients of the line equation
linear_eqn.c=c; % store interceptions point of the line equation

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Measuring signal intensity of each point along the line %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Run through all the points selected on the mask and record intensity
% value and distance of each point along each line
for j=(1:length(take_index)) % each loop considers each line
    
    % Call each selected point on spheroid inner edge
    xref=x_edge(j);
    yref=y_edge(j);
    
    % Find the length (L) of the line (in pixel)
    dis_x=(xref-x_centre);
    dis_y=(yref-y_centre);
    L=sqrt(((dis_x)^2)+((dis_y)^2));

    % Create the list of distance of interest e.g. measuring every x um
    distance_pixel=(0.1:(step*calibration):L);
    distance_um=distance_pixel./calibration;
    
    A=(m(j)^2)+1;
    B=2*((m(j)*c(j))-xref-(m(j)*yref));
    C=(xref^2)+(yref^2)-(2*yref*c(j))+(c(j)^2)-(distance_pixel.^2); % list of C values for distances of interest

    if xref<x_centre
        % add +centre or -centre to make the number of data
        % points equal for both size of the spheroid 
        % need to call x and y coordinates along the line at the distance
        % of interest
        x_inner=(-B+sqrt((B^2)-(4*A.*C)))./(2*A); % list of x-coordinate inside spheroid
        x_outer=(-B-sqrt((B^2)-(4*A.*C)))./(2*A); % list of x-coordinate outside spheroid
        % Call its linear equation
        y_inner=(m(j).*x_inner)+c(j);
        y_outer=(m(j).*x_outer)+c(j);
    elseif xref>x_centre
        x_inner=(-B-sqrt((B^2)-(4*A.*C)))./(2*A);
        x_outer=(-B+sqrt((B^2)-(4*A.*C)))./(2*A);
        % Call its linear equation
        y_inner=(m(j).*x_inner)+c(j);
        y_outer=(m(j).*x_outer)+c(j);
    elseif xref==x_centre
        x_inner=repelem(x_centre,length(distance_pixel));
        x_outer=repelem(x_centre,length(diatance_pixel));
        if yref>y_centre
            y_inner=yref-distance_pixel; 
            y_outer=yref+distance_pixel;
        else
            y_inner=yref+distance_pixel; 
            y_outer=yref-distance_pixel;
        end
    end

    % Find intensity of every points on the line
    [data_x,data_y,intensity_before_subtract_BG] = improfile(apply_mask,x_inner,y_inner,length(x_inner));
    % mesure the intensity of each pixel that the line pass (line thickness
    % is a pixel size)
  
    intensity=intensity_before_subtract_BG-avg_bg;
% ------------------------------------------------------------------------
%%% OPTIONAL %%%
    figure(1)
    line([xref x_centre],[yref y_centre],'Color','b')
    plot(x_inner, y_inner,'r+')
    
    figure(2)
    % Plot intensity profile
    plot (distance_um,intensity,'b-')
% ------------------------------------------------------------------------
    
    
    % Store outputs in parameter intensity profile (structure)
    intensity_profile(j).distance=distance_um;
    intensity_profile(j).length=L;
    intensity_profile(j).intensity=intensity;
    intensity_profile(j).x_coor=data_x;
    intensity_profile(j).y_coor=data_y;
    intensity_profile(j).num_points=length(distance_pixel);
    % Store number of points on the line that we considered
    
    
    clear distance_list A B C xref yref
   
end
hold off
end

    