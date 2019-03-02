%% usage: maglin = lininterp (F,mag,m,fs)
%%
%% Obtiene la valores interpolados sobre el semiespectro.
%%
%% maglin = Magnitud interpolada.
%% mag    = Magnitud a interpolar.
%% F      = Vector de frecuencias.
%% m      = Longitud del espectro completo (debe ser par).
%% fs     = Frecuencia de muestreo.

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

function maglin = lininterp (F, mag, m, fs)

if ! iscolumn(F)
    error ("F must be a column vector")
end

    fnew = (0:m/2)'*fs/m; % column vector
    maglin = interp1(F, mag, fnew, "spline","extrap");
    
endfunction
