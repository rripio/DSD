%% usage: [trw1,trw2] = trwcoslog(n1,n2)
%%
%% Genera ventanas de transición complementarias en un intervalo dado,
%% según una función 'raised cosine'.
%%
%% Los datos de entrada han de estar en magnitudes logarítmicas,
%% tanto en frecuencia como en valor.
%%
%% trw1 = Ventana de transición de izquierda a derecha.
%% trw2 = Ventana de transición de derecha a izquierda.
%% n1   = Índice del extremo izquierdo de la ventana.
%% n2   = Índice del extremo derecho de la ventana.

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

function [trw1,trw2] = trwcoslog(n1,n2)

    l=(0:n2-n1)'/(n2-n1)*pi;
    trw1=(cos(l)+1)/2;
    trw2=1-trw1;
    
endfunction
