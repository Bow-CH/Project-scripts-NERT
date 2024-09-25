function [im, info] = BrukerReadImage(path)
% 20160428 BMS Genesis, though vast majority is based on RR's seperate 3D
%              and 2D file openers vintage 2013. Merged to avoid code duplication.
% 20170622 BMS Add angled brackets for Spatial dimensions. Change in PV6???
%              Also add echoes  

% Get infomation from method file
ACQP = BrukerReadParamFile('acqp',path);
PVM = BrukerReadParamFile('method',path);
RECOP = BrukerReadParamFile('reco',path);
VISU = BrukerReadParamFile('visu',path);

% checking the image dimension and assign the value to spatdims
if (strcmp(PVM.SpatDimEnum,'2D') || strcmp(PVM.SpatDimEnum,'<2D>'))
    % expr 2 is not evaluated if expr 1 is true
    % either expr 1 or expr 2 is true 
    spatdims=2;
elseif (strcmp(PVM.SpatDimEnum,'3D') || strcmp(PVM.SpatDimEnum,'<3D>'))
    spatdims=3;
else 
    error('Unknown imaging acquisition dimentionality');
end


if spatdims==2;
    dimension = zeros([1:3]); %preallocation
    dimension = RECOP.RECO_size(1:2); %take the dimension from data 'reco'
    
    if PVM.NEchoImages > 1 % Hmmm... not sure if I really need an if here
        dimension = [dimension ACQP.NECHOES];
    end
    
    if ACQP.NI > 1 % Hmmm... might need to do something here for timcouses?
    end 
    
    if isfield(PVM,'NMovieFrames') % for cine, not sure if it goes here
        dimension = [dimension PVM.NMovieFrames]; 
    end
    
    dimension = [dimension ACQP.NSLICES];
    
elseif spatdims==3;
    
    dimension = PVM.Matrix(1:3);
    if ACQP.NECHOES > 1 % Hmmm... not sure if I really need an if here
        dimension = [dimension ACQP.NECHOES];
    end
end

dimension = [dimension ACQP.NR];

% Get datatype
if strcmp(RECOP.RECO_wordtype,'_32BIT_SGN_INT')
    wt = 'int32';
elseif strcmp(RECOP.RECO_wordtype,'_16BIT_SGN_INT')
    wt = 'int16';
elseif strcmp(RECOP.RECO_wordtype,'_8BIT_UNSGN_INT')
    wt = 'uint8';
elseif strcmp(RECOP.RECO_wordtype,'_32BIT_FLOAT')
    wt = 'float32';
else
    error('Datatype not recognised');
end

% Get endianness
if strcmp(RECOP.RECO_byte_order,'littleEndian')
    bo = 'l';
elseif strcmp(RECOP.RECO_byte_order,'bigEndian')
    bo = 'b';
else
    bo = 'l';
end
    



% Retrieve image data from 2dseq file (not fid)
imagepath = [path '/pdata/1/2dseq']; %2dseq file usually kept at this address
f1 = fopen(imagepath,'r'); % open file for read only
A=fread(f1,inf,wt,0,bo); %A = fread(FID,SIZE,PRECISION,SKIP,MACHINEFORMAT)
fclose(f1);

if spatdims==2
    im = reshape(A,dimension);
elseif spatdims==3
    im = reshape(A,dimension(2),dimension(1),dimension(3),dimension(4));
    im = permute(im,[2 1 3 4]);
end

info.ACQP = ACQP;
info.PVM = PVM;
info.RECOP = RECOP;
info.VISU = VISU;

end
