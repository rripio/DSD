%% usage pcm = loadpcm(fname)
%%
%% load a pcm raw file created by DRC
%%
%% pcm    = Impulse column vector
%% fname  = pcm file name
%%
%% The file must be in 32 bit floating point format

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

function pcm = loadpcm(fname)

    f = fopen(fname,"rb");
    [pcm, pcmc] = fread(f,inf,"float32");
    fclose(f);
    
endfunction
