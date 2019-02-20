%% This file is part of DSD
%%
%% DSD
%%
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

%% usage: gainpcm (filename, gaindB)
%%
%% Aplica una cierta ganancia en dB a un archivo pcm y lo guarda.
%%
%% filename    = Nombres del archivo pcm.
%% gaindB    = Ganancia a aplicar (dB).

function gainpcm (filename, gaindB)

    imp = loadpcm(filename);
    gain = dB2mag(gaindB);
    imp = imp * gain;
    savepcm(imp,filename);

endfunction
