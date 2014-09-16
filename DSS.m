%% Copyright (C) 2012 Roberto Ripio
%%
%% This program is free software; you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published by
%% the Free Software Foundation; either version 2 of the License, or
%% (at your option) any later version.
%%
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%%
%% You should have received a copy of the GNU General Public License
%% along with this program; if not, write to the Free Software
%% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
%%
%% This function is part of DSD

%% usage: imp = [mag, phase] = DSS (F,fs)
%%
%% Obtiene los valores de la ecualización DSS sobre un vector de frecuencias f.
%% ' Let's call this filter DSS (yes, it also de-esses), short for "Don & Siegfried's Shelf" '
%% http://www.linkwitzlab.com/frontiers_7.htm#A2
%%
%% mag = Vector de magnitudes (dB).
%% phase = Vector de fases (deg).
%% F = Vector de frecuencias.
%% fs = Frecuencia de muestreo.

function [mag, phase] = DSS (F,fs);

	if ! iscolumn(F)
		error ("F must be a column vector")
	end

    f1 = 1800;
    Q = 0.5;
    gain_dBS = -3.2;
    [b,a] = biquad (fs, f1, Q, "highShelf", gain_dBS);
    h = freqz(b, a, F, fs);
    mag = mag2dB(abs(h)); phase = arg(h)*180/pi;
    
endfunction
