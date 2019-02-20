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

%% usage: audioplot(F, dBmag, bottom, top, step, plotitle)
%%
%% Dibuja una gráfica de respuesta en frecuencia con un formato convencional.
%%
%% F    = Vector de frecuencias.
%% dBmag    = Vector de magnitudes en dB.
%% bottom    = Mínimo de la magnitud (dB).
%% top    = Máximo de la magnitud (dB).
%% step    = Escalones de dB a efectos de rejilla y rotulación.
%% plotitle    = TÍtulo de la gráfica.

function audioplot(F, dBmag, bottom, top, step, plotitle)

% plots magnitude responses
FLow = 5; FHigh = 20000;

semilogx(F/1000,dBmag);

set(axe, "title", plotitle);
set(axe, "xlabel", "Frequency (KHz)");
set(axe, "ylabel", "Magnitude (dB)");
set(axe, "xlim", [(PSFLow/1000),(PSFHigh/1000)]);
set(axe, "ylim", [bottom,top]);
set(axe, "xgrid", "on");
set(axe, "ygrid", "on");
set(axe, "xtick", [0.01;0.02;0.03;0.05;0.1;0.2;0.3;0.5;1;2;3;5;10;20]);
set(axe, "xticklabel", ['.01';'.02';'.03';'.05';'.1';'.2';'.3';'.5';'1';'2';'3';'5';'10';'20']);
set(axe, "ytick", (PSVBottom:PSVStep:PSVTop));

endfunction
