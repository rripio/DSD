%% usage: [freq, magdB, pha] = loadfrd (filename)
%%
%% Reads frequency response data from a .frd file.
%%
%% Lines with non numeric data are discarded.
%%
%% freq     = Frequency vector.
%% magdB    = dB magnitude.
%% pha      = Phase.
%% filename = .frd file full name.

%% This file is part of DSD
%%
%% DSD
%% A GNU-Octave set of scripts for calculating
%% digital loudspeaker crossovers and room correction filters
%% Copyright (C) 2012-2019 Roberto Ripio
%%
%% DSD is free software: you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published by
%% the Free Software Foundation, either version 3 of the License, or
%% (at your option) any later version.
%%
%% DSD is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%%
%% You should have received a copy of the GNU General Public License
%% along with DSD.  If not, see <https://www.gnu.org/licenses/>.

function [freq, magdB, pha] = loadfrd (filename)

    result = [];

    fid=fopen(filename);
    while 1
        tline = fgetl(fid);
        if ~ischar(tline), break, end
        celldata = textscan(tline,'%f %f %f');
        matdata = cell2mat(celldata);
        % match fails for text lines, textscan returns empty cells
        result = [result ; matdata];
    end
    fclose(fid);

    freq  = result(:,1);
    magdB = result(:,2);
    pha   = result(:,3);

endfunction

