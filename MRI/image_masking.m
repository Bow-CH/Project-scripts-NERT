function [masking]=image_masking(image)
% image masking function
    masking={};
    e = imrect(gca,[0 0 6 6]); %create masking 6x6
    
    for i=(1:12)
        position = wait(e); % wait for response
        masking{i} = createMask(e,image); % concentration=0.5mg/ml
        i
    end
    
    
end
