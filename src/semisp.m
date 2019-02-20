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

%% usage: ssp = semisp (sp)
%%
%% Obtiene el espectro de las frecuencias positivas a partir de un espectro completo.
%%
%% ssp = Espectro de las frecuencias positivas entre 0 y m/2.
%% sp = Espectro completo entre 0 y m-1 (m par).

function ssp = semisp (sp)

    if ! iscolumn(sp)
        error ("sp must be a column vector")
    end

    m = length (sp);
    
    if (mod(m,2) != 0)
        error ("semisp: Spectrum length must be even");
    end
    
    ssp = sp(1:m/2+1);
    
endfunction
