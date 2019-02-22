%% usage: audioplot(F, dBmag, bottom, top, step, plotitle)
%%
%% Dibuja una gráfica de respuesta en frecuencia con un formato convencional.
%%
%% F        = Vector de frecuencias.
%% dBmag    = Vector de magnitudes en dB.
%% bottom   = Mínimo de la magnitud (dB).
%% top      = Máximo de la magnitud (dB).
%% step     = Escalones de dB a efectos de rejilla y rotulación.
%% f_low    = Límite inferior de frecuencias (Hz).
%% f_high   = Límite superior de frecuencias (Hz).
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

function audioplot( F,
                    dBmag,
                    bottom=-18,
                    top=+6,
                    step=3,
                    f_low=10,
                    f_high=30000,
                    plotitle="Frequency response")

semilogx(F/1000,dBmag);

axe=gca();

set(axe, "title", plotitle);
set(axe, "xlabel", "Frequency (Hz)");
set(axe, "ylabel", "Magnitude (dB)");
set(axe, "xlim", [(f_low/1000),(f_high/1000)]);
set(axe, "ylim", [bottom,top]);
set(axe, "xgrid", "on");
set(axe, "ygrid", "on");
set(axe, "xtick", ...
            [0.001;0.005;0.01;0.02;0.03;0.05 ...
            ;0.1;0.2;0.3;0.5;1;2;3;5;10;20;30]);
set(axe, "xticklabel", ...
    ['1';'5';'10';'20';'30';'50';'100';'200';'300';'500'...
    ;'1k';'2k';'3k';'5k';'10k';'20k';'30k']);
set(axe, "ytick", (bottom-(100-mod(100,step)):step:top+100));

endfunction
