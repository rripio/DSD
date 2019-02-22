%% usage: [mag, phase] = RoomGain (f, gain_dBS, fs)
%%
%% Obtiene los valores de la ecualización Room Gain
%% sobre un vector de frecuencias f.
%%
%% mag      = Vector de magnitudes.
%% pha      = Vector de fases.
%% F        = Vector de frecuencias.
%% gain_dBS = Ganancia total a DC sobre la respuesta plana.
%% fs       = Frecuencia de muestreo.

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

function [mag, phase] = RoomGain (F, gain_dBS, fs);

    if ! iscolumn(F)
        error ("F must be a column vector")
    end

    f1 = 120;
    Q = 0.707;
    [b,a] = biquad (fs, f1, Q, "lowShelf", gain_dBS);
    h = freqz(b, a, F, fs);
    mag = mag2dB(abs(h)); mag -= max(mag);
    phase = arg(h)*180/pi;
    
endfunction
