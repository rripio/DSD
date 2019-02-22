%% usage: [b,a] = biqshelving(fs, f1, f2, type)
%%
%% Obtiene los coeficientes del filtro IIR asociado a un filtro shelving
%% tal como se define en www.linkwitzlab.com.
%% La pendiente se limita a la ausencia de overshoot,
%% con un máximo de 6 dB/oct.
%%
%% [b,a] = Coeficientes del filtro IIR.
%% fs    = Frecuencia de muestreo.
%% f1    = Frecuencia de inicio de la pendiente.
%% f2    = Frecuencia final de la pendiente.
%% type  = Valor de cadena entre: lowShelf o highShelf.

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

function [b,a] = biqshelving(fs, f1, f2, type);

if (f2 <= f1)
    error ("f2 must be grater than f1")
end

s = 6; % linkwitz shelvings, 6 dB/oct
f0 = sqrt(f1*f2);
w0 = 2*pi*f0/fs;
dBgain = 20*log10(f2/f1);
A  = 10^(dBgain/40);
S = s * log2(10)/40 * sin(w0)/w0 * (A^2+1)/abs(A^2-1);
if S>1; S=1; end;
Q = 1/(sqrt((A + 1/A)*(1/S - 1) + 2));

[b,a]=biquad(fs,f0,Q,type,dBgain);

endfunction
