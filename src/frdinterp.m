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

%% usage: magdB = frdinterp (filename, m, Fs)
%%
%% Obtiene la magnitud en decibelios sobre el semiespectro a partir de un archivo .frd.
%%
%% magdB     = Magnitud en dB sobre el semiespectro.
%% filename = Nombre del archivo .frd.
%% m     = Longitud del espectro completo (debe ser par).
%% fs     = Frecuencia de muestreo.

function magdB = frdinterp (filename, m, Fs)

    a=load(filename);
    fa=a(:,1); maga=a(:,2); clear a;
    magdB = lininterp (fa, maga, m, Fs);
    
endfunction
