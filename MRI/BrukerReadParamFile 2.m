function PROCPAR_B = BrukerReadParamFile(paramfile,datapath,recono)
%BrukerReadParamFile Reads bruker parameter files
%   PROCPAR_B = BrukerReadParamFile(paramfile,datapath,recono)
%   Returns PROCPAR_B structure with all parameters in PARAMFILE
%   PARAMFILE could be either ACQP, METHOD, RECO
%   DATAPATH is path to scan directory
%   RECONO is the reconstruction number, only required for RECO

% Who   When        What
% BMS   20131210    Genesis, based on RR's m-files that read files individually
%                   A single m-file for all params files avoids code
%                   duplication since all bruker param files seem quite
%                   similar (to be confirmed!)

% Input full data directory which includes the method file i.e. 'user.subject\1\'

if nargin <3
    recono = 1;
end

if (strcmpi(paramfile,'reco'))
    fprocpar = fopen(fullfile(datapath, 'pdata', num2str(recono), 'reco'), 'r');
elseif (strcmpi(paramfile,'acqp'))
    fprocpar = fopen(fullfile(datapath, 'acqp'), 'r');
elseif (strcmpi(paramfile,'method'))
    fprocpar = fopen(fullfile(datapath, 'method'), 'r');
elseif (strcmpi(paramfile,'visu'))
    fprocpar = fopen(fullfile(datapath, 'visu_pars'), 'r');    
    
end
    
% RR 11/12/13 altered file reader to account for multi-line arrays + cleaner function for structure naming.

done=0;
while(~done)
    
    line2 = fgets(fprocpar);
    if line2 == -1
        done = 1;
    else
        
        if( ~isempty(findstr(line2, '##')) )
            if( ~isempty(findstr(line2, '$')) )
                if( ~isempty(findstr(line2, '(')) )
                    % Some parameters have array size specified in
                    % brackets ( size ) with values on next line
                    
                    [len] = strtok(line2, '=');
                    len = len(4:end);
                    
                    line2 = fgets(fprocpar); % Read next line
                    
                    if max(isstrprop(strtrim(line2), 'alpha')) == 0
                        
                        a = str2num(line2);
                        arraydone = 0;
                        
                        while (~arraydone)
                            % Loop next lines to determine if array
                            % continues over more than one line.
                            linetest = fgets(fprocpar);
                            if max(isstrprop(strtrim(linetest), 'alpha')) == 0
                                a = [a str2num(linetest)];
                            else
                                arraydone = 1;
                                % Rewind back if a text line is found.
                                fseek(fprocpar, -length(linetest), 0);
                            end
                        end
                        
                        len = StructNameClean(len);
                        PROCPAR_B.(genvarname(len)) = a;
                        
                    else
                        lll = strtrim(line2);
                        len = StructNameClean(len);
                        PROCPAR_B.(genvarname(len)) = lll(2:end-1); % tidy up string
                    end
                else
                    [len, rem] = strtok(line2, '=');
                    len = len(4:end);
                    rem = rem(2:end);
                    len = StructNameClean(len);
                    
                    if max(isstrprop(strtrim(rem), 'alpha')) == 0
                        PROCPAR_B.(genvarname(len)) = str2num(rem);
                    else
                        PROCPAR_B.(genvarname(len)) = strtrim(rem);
                    end
                end
                
            else
                % Some (typically string descriptions) have just a '##'
                % prefix.
                
                if( ~isempty(findstr(line2, '(')) )
                    % Some parameters have array size specified in
                    % brackets ( size ) with values on next line
                    
                    [len] = strtok(line2, '=');
                    len = len(8:end);
                    
                    line2 = fgets(fprocpar); % Read next line
                    
                    if max(isstrprop(strtrim(line2), 'alpha')) == 0
                        
                        a = str2num(line2);
                        arraydone = 0;
                        
                        while (~arraydone)
                            % Loop next lines to determine if array
                            % continues over more than one line.
                            linetest = fgets(fprocpar);
                            if max(isstrprop(strtrim(linetest), 'alpha')) == 0
                                a = [a str2num(linetest)];
                            else
                                arraydone = 1;
                                % Rewind back if a text line is found.
                                fseek(fprocpar, -length(linetest), 0);
                            end
                        end
                        
                        len = StructNameClean(len);
                        PROCPAR_B.(genvarname(len)) = a;
                        
                    else
                        lll = strtrim(line2);
                        len = StructNameClean(len);
                        PROCPAR_B.(genvarname(len)) = lll(2:end-1); % tidy up string
                    end
                else
                    [len, rem] = strtok(line2, '=');
                    len = StructNameClean(len);
                    a = strfind(rem, '=');
                    rem(a) = '';
                    
                    if max(isstrprop(strtrim(rem), 'alpha')) == 0
                        PROCPAR_B.(genvarname(len)) = str2num(rem);
                    else
                        PROCPAR_B.(genvarname(len)) = strtrim(rem);
                    end
                    
                end
            end
        end
    end
end

end

function lineout = StructNameClean(linein)
lineout = linein;
a = strfind(linein, '#');
lineout(a) = '';
a = strfind(linein, '$');
lineout(a) = '';
a = strfind(linein, 'PVM_');
lineout(a:a+3) = '';

end
