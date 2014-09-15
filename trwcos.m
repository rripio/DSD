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

%% usage: [trw1,trw2] = trwcos(n1,n2)
%%
%% Genera ventanas de transición complementarias en un intervalo dado, según una función
%% 'raised cosine' en escala de frecuencias logarítmica.
%%
%% trw1	= ventana de transición de izquierda a derecha.
%% trw2	= ventana de transición de derecha a izquierda.
%% n1	= Índice del extremo izquierdo de la ventana.
%% n2	= Índice del extremo derecho de la ventana.

function [trw1,trw2] = trwcos(n1,n2)

    nm=(n1*n2)^.5;
    k1=nm-n1; k2=n2-n1;
    n=(0:n2-n1)';
    a=(log(e^pi-1)-log(e^(pi/2)-1))/(log(k2)-log(k1));
    b=log(e^pi-1)-a*log(k2);
    c=e^b;
    l=log(c*(n.^a)+1);
    trw1=(cos(l)+1)/2;
    trw2=1-trw1;
    
endfunction