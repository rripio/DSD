%% usage: x = buttwindow (m,ppo,ppoSm)
%%
%% Genera una ventana estándar de promediado de potencia
%% con filtrado butterworth de 6º orden.
%%
%% x     = Ventana.
%% m     = Longitud del espectro logarítmico a promediar.
%% ppo   = Fracción de octava del intervalo de frecuencias. 
%% ppoSm = Fracción de octava del suavizado.

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

function x=buttwindow(m,ppo,ppoSm);
    w=logfreq(m,2*pi,ppo);
    [b,a]=butter(6,[0.2/2^(1/ppoSm),0.2]);
    x=abs(freqz(b,a,w)).^2;
    x=x(x>dB2pow(-20)); x=x/sum(x);
end
