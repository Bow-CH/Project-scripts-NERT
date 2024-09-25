%%% Call area and roundness data from OrganoSeg %%%
%%% UPDATED 14/05/2024 %%%
%%% corrected calibration factor: changed from multiplication to division


%%%%%%%%%%%%%%%%%%%%%%%% INPUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
calibration_factor=1; % convert the value from pixel to um (unit pixel/um)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Pre-define the list and parameter
number_spheroid=length(signatureStruct);
list_roundness=zeros(1,number_spheroid);
list_area=zeros(1,number_spheroid);
list_diameter=zeros(1,number_spheroid);



for i=(1:number_spheroid)
    % pull out data for roundness and area 
    list_roundness(i)=signatureStruct{1, i}.MinorAxisLength/signatureStruct{1, i}.MajorAxisLength; 
    list_area(i)=(signatureStruct{1, i}.Area)/calibration_factor;
   
    % calculate diameter of the spheroid based on the area (assume spheroid
    % is round)
    list_diameter(i)=2*sqrt((signatureStruct{1, i}.Area)/(calibration_factor*pi));
end



