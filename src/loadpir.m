%% usage pcm = loadpir(fname)
%%
%% load a pir file created by ARTA
%%
%% pcm    = Vector columna del impulso
%% fname = pir file name

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

function [pir, fs] = loadpir(fname)

    f = fopen(fname,"rb");
    [filesignature, filesignaturec] = fread(f, 4, "char");
    [version, versionc] = fread(f, 1, "unsigned int");
    [infosize, infosizec] = fread(f, 1, "int");
    [reserved, reservedc] = fread(f, 2, "int");
    [fskHz, fskHzc] = fread(f, 1, "float");
    [fs, fsc] = fread(f, 1, "int");
    [pirlength, pirlengthc] = fread(f, 1, "int");
    [inputdevice, inputdevicec] = fread(f, 1, "int");
    [devicesens, devicesensc] = fread(f, 1, "float");
    [various_int, various_intc] = fread(f, 5, "int");
    [various_float, various_floatc] = fread(f, 5, "float");
    [pir, pirc] = fread(f, pirlength, "float");
    % Don't read text
    fclose(f);
    
endfunction
