function [output]=average_intensity_profile(intensity_profile)
%{
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Parameters explanation %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT
% - Structure array of intensity_profile contains information of 
% > distance: distance of points on the line to the spheroid edge for every lines that
%   we consider
% > length: length of each line
% > intensity: intensity of the image along each point on the lines
% > x_coor and y_coor: x and y coordinates of each points along the lines
% > num_points: the number of points along each line
%
% OUTPUT
% - Mean distance and intensity
% - Upper and lower errors of distance and intensity
% 
%}

% Define parameters
list_num_points=[intensity_profile(:).num_points];
distance_all=nan([length(intensity_profile) max(list_num_points)]); % create matrix with size of number of line X number of points on each line
intensity_all=nan([length(intensity_profile) max(list_num_points)]);
ts=[];
output=struct;

% Call out the data for distance and intensity and put the data in the
% separate list
for n=(1:numel(intensity_profile))
    if intensity_profile(n).distance(1)<0
        % we need to range the data to the same order on both side of the
        % spheroid as we will average every first points of each line
        % together and second points of each line etc. so we need to flip
        % the list of the data of one side of the sphere (both sides of the
        % sphere are the mirror reflection of each other) without flipping
        % the data will be arrange by lower x to higher x
        distance_all(n,(1:list_num_points(n)))=fliplr(intensity_profile(n).distance);
        intensity_all(n,(1:list_num_points(n)))=fliplr((intensity_profile(n).intensity)');
    else
        distance_all(n,(1:list_num_points(n)))=intensity_profile(n).distance;
        intensity_all(n,(1:list_num_points(n)))=intensity_profile(n).intensity;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Find mean and error at 95% confident interval for distance %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
number_data_average=sum(~isnan(distance_all)); % number of data points included in mean calculation

% T-score for 5% (2-tail)
for m=(1:numel(number_data_average))
    ts=[ts,tinv([0.025  0.975],number_data_average(m)-1)]; % T-Score
end
ts_lower=(ts(1:2:end));
ts_upper=(ts(2:2:end));
    
% Mean and CI of distance
mean_distance=mean(distance_all,"omitnan");
SEM_distance=std(distance_all,"omitnan")./sqrt(number_data_average); % Standard Error
CI_distance_lower=(mean_distance+ts_lower).*(SEM_distance);
CI_distance_upper=(mean_distance+ts_upper).*(SEM_distance);

% Mean and CI of intensity
mean_intensity=mean(intensity_all,"omitnan");
SEM_intensity=std(intensity_all,"omitnan")./sqrt(number_data_average); % Standard Error
CI_intensity_lower=(mean_intensity+ts_lower).*(SEM_intensity);
CI_intensity_upper=(mean_intensity+ts_upper).*(SEM_intensity);

% max intensity for normalisation
max_intensity=max(intensity_all);
%{    
    % Find mean and error at 95% confident interval for intensity
    mean_intensity=[mean_intensity,mean(intensity_ex_nan_col)];
    SEM_intensity=[SEM_intensity,std(intensity_ex_nan_col)./sqrt(length(intensity_ex_nan_col))];               % Standard Error
    ts_intensity=tinv([0.025  0.975],length(intensity_ex_nan_col)-1);      % T-Score
    CI_intensity={mean(intensity_ex_nan_col)+ts_intensity*(std(intensity_ex_nan_col)/sqrt(length(intensity_ex_nan_col)))};
    list_CI_intensity=[list_CI_intensity,CI_intensity];

%}


% Plot
errorbar(mean_distance,mean_intensity,SEM_intensity,SEM_intensity,CI_distance_lower,CI_distance_lower)
hold on
%plot( [0,0],[0,1],'r-') % enter the spheroid
plot(mean_distance,mean_intensity,'b*')
%ylim([0 1])
title('Intensity Profile')
xlabel('Distance (um)') 
ylabel('Intensity')

% Output
output.mean_distance=mean_distance;
output.errorUpper_distance=CI_distance_upper;
output.errorLower_distance=CI_distance_lower;
output.mean_intensity=mean_intensity;
output.errorUpper_intensity=CI_intensity_upper;
output.errorLower_intensity=CI_intensity_lower;
output.max_intensity=max_intensity;
output.SEM_intensity=SEM_intensity;
output.SEM_distance=SEM_distance;

end

