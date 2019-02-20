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

%% usage: imps = loadpcms (filemask, kinit, kend)
%%
%% Carga archivos impulso que verifican una máscara en una matriz de vectores columna.
%%
%% imps    = matriz de vectores columna con los impulsos.
%% n        = Número de impulsos.
%% filemask    = Máscara de nombres de archivo (string).
%% kinit    = Índice para el comienzo del recorte.
%% kend        = Índice para el comienzo del recorte.

function [imps, n] = loadpcms (filemask, kinit, kend)

    impnames = glob (filemask);
    n = size (impnames, 1);
    l = kend-kinit+1;
    imps = zeros(l, n);
    for i = 1:n;
        temp = loadpcm(impnames(i));
        temp = temp(kinit:kend);
        imps(:,i) = temp;
    end;

endfunction
