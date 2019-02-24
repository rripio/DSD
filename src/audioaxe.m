%% usage: axe = audioaxe(...
%%                  magtop, magrange, magstep, flow, fhigh, plotitle)
%%
%% Dibuja una gráfica de respuesta en frecuencia con un formato convencional.
%%
%% axe      = Ejes de la figura.
%% magtop   = Máximo de la magnitud (dB).
%% magrange = Rango visible de la magnitud (dB).
%% magstep  = Escalones de dB a efectos de rejilla y rotulación.
%% flow     = Límite inferior de frecuencias (Hz).
%% fhigh    = Límite superior de frecuencias (Hz).
%% plotitle = Título de la gráfica.

%% This file is part of DSD
%%
%% DSD
%% GNU-Octave set of scripts for calculating
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
%%

function audioaxe( magtop=+6,
                       magrange=24,
                       magstep=3,
                       flow=10,
                       fhigh=30000,
                       plotitle="Frequency response" )

magbottom=magtop-magrange;
axe=gca();

set(axe, "title", plotitle);
set(axe, "xlabel", "Frequency (Hz)");
set(axe, "ylabel", "Magnitude (dB)");
set(axe, "xlim", [flow,fhigh]);
set(axe, "ylim", [magbottom,magtop]);
set(axe, "xgrid", "on");
set(axe, "ygrid", "on");
set(axe, "xtick", ...
    [1;5;10;20;30;50;100;200;...
    300;500;1000;2000;3000;...
    5000;10000;20000;30000]);
set(axe, "xticklabel", ...
    ['1';'5';'10';'20';'30';'50';'100';'200';'300';...
    '500';'1k';'2k';'3k';'5k';'10k';'20k';'30k']);
set(axe, "ytick", (magbottom-(100-mod(100,magstep)):magstep:magtop+100));

endfunction
